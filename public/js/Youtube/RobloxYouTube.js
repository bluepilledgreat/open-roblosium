var RobloxYouTube = RobloxYouTube ||
{
    Events:
    {
        States:
            {
                Unstarted: -1,
                Ended: 0,
                Playing: 1,
                Paused: 2,
                Buffering: 3,
                VideoCued: 5
            },
        Errors:
            {
                InvalidParameters: 2,
                VideoNotFound: 100,
                NotEmbeddable: 101,
                NotEmbeddable2: 150 // Same as embeddable 1  (http://code.google.com/apis/youtube/js_api_reference.html#Events)
            }
    }
};

RobloxYouTubeVideoManager = function () {
    _AllVideosOnPage = new Array();
    
    function AddVideo(video) {
        _AllVideosOnPage[video.RobloxVideoPlayerID] = video;
        return video;
    }
    function GetVideo(videoId) {
        return _AllVideosOnPage[videoId];
    }
    return {
        AddVideo: AddVideo,
        GetVideo: GetVideo
    };
} ();

function RobloxYouTubeVideo(videoPlayerId, stateChangeCallback)
{
    var self = this;
    this.RobloxVideoPlayerID = videoPlayerId;
    this.OnPlayerStateChangeCallback = function (state) {
        stateChangeCallback(state, videoPlayerId, self); 
    }     // function called when state is changed
    this.YouTubeVideoID = null;
    this.Chromeless = false;
    this.Autoplay = false;
    this.Muted = false;

    this.Player = function()
    {
        return document.getElementById(this.RobloxVideoPlayerID);
    };
    // Arguments:
    // chromeless: Render this video in chromeless mode or not
    // youTubeVideoId: id of video on youtube
    // divToFill: ID of a div to replace with the video.  This should ideally be a div containing the message: "You need Flash player 8+ and JavaScript enabled to view this video.", that will be replaced when the video loads (if possible)
    this.Init = function (youTubeVideoId, chromeless, divToFillId, width, height, autoplay) {
        this.YouTubeVideoID = youTubeVideoId;
        this.Chromeless = chromeless;
        this.Autoplay = autoplay;
        this.Muted = autoplay;

        var youTubeUrl = "http://www.youtube.com/";
        if (false) {
            youTubeUrl += "apiplayer?video_id=" + youTubeVideoId + "&";
        }
        else {
            youTubeUrl += "v/" + youTubeVideoId + "?";
        }
        youTubeUrl += "&rel=0&showinfo=0&showsearch=0&fs=0&version=3&autohide=1&enablejsapi=1&iv_load_policy=3&playerapiid=" + this.RobloxVideoPlayerID;
        var params = {
            allowScriptAccess: "always",
            wmode: "opaque"  // Needed to allow our overlay to go ontop
        };
        var atts = { id: this.RobloxVideoPlayerID };
        var flashvars = { wmode: "opaque" };
        //Arguments: http://code.google.com/p/swfobject/wiki/documentation
        //Args: swfUrl, id, width, height, version, expressInstallSwfurl, flashvars, params, attributes, callbackFn) has five required and five optional arguments:

        var swfobj = swfobject.embedSWF(youTubeUrl, divToFillId, width, height, "8", null, flashvars, params, atts);

    };
    this.SeekToTime = function(secondsMark) {
        this.Player().seekTo(secondsMark, true); // Jump to a specific seconds mark
    };
    this.PauseVideo = function () {
        this.Player().pauseVideo();
    }
}

// Needs to be in the global namespace -- called by YouTube 
function onYouTubePlayerReady(playerId) 
{
    // addEventListener is being overwritten by the youtube API.  It requires that the function passed in is a string (this is because it's calling back across SWF boundaries).
    // https://groups.google.com/group/youtube-api-gdata/browse_thread/thread/e8a8c85b801b9e25?pli=1
    var video = RobloxYouTubeVideoManager.GetVideo(playerId);
    var player = video.Player();
    player.addEventListener("onStateChange", "RobloxYouTubeVideoManager.GetVideo('" + playerId + "').OnPlayerStateChangeCallback");
    if (video.Muted)
        player.mute();

    if (video.Autoplay)
        player.playVideo();
}
