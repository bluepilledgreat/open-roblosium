
if (typeof Admin === "undefined") {
    Admin = {};
}

Admin.FeaturedPlaces = function() {

    var selectedPlaceIdEdit;

    $('#NewPlatformInput').keypress(function(e) {
        if (e.keyCode == 13) {
            var name = $('#NewPlatformInput').val();
            $.post('/featuredplaces/AddPlatformType', { platformName: name }, function(data) {
                $('#ListOfPlatforms').html(data);
                $('#NewPlatformInput').val("");
            });
        }
    });
    $('.btn-cancel').click(function() {
        $.modal.close();
    });
    $('.btn-submit').click(function() {
        var selectedPlaceId = $('#PlaceIDInput').val();
        var url = '/featuredplaces/CreateFeaturedPlace?';
        if (selectedPlaceId == undefined) {
            selectedPlaceId = selectedPlaceIdEdit;
            url = '/featuredplaces/EditFeaturedPlace?';
        }
        var platforms = $('input.platformFilter:checked').map(function() { return $(this).data('platformid'); }).get();
        if (platforms != null) {
            for (var i = 0; i < platforms.length; i++) {
                url += "platformTypeIds=" + platforms[i] + "&";
            }
        }
        url += 'placeId=' + selectedPlaceId;
        $.post(url, function(data) {
            window.location = "/CreateFeaturedPlaces";
        });
    });

    $('#CreateNewFeaturedPlaceLink').click(function() {
        GenericModal.open("Featured Place", null, null, null /* no callback */);
        $.get('/featuredplaces/GetFeaturedPlaceInfo', function(data) {
            $('#FeaturedPlaceData').html(data);
        });
    });

    $('#PlatformTypeSelect').change(function() {
        var selectedplatform = document.getElementById('PlatformTypeSelect').value;
        window.location = "/CreateFeaturedPlaces?platformTypeId=" + selectedplatform;
    });

    $('.WhiteSquareTabsContainer li').bind('click', function() {
        SwitchTabs($(this));
    });

    function SwitchTabs(nextTabElem) {
        $('.WhiteSquareTabsContainer .selected, #TabsContentContainer .selected').removeClass('selected');
        nextTabElem.addClass('selected');
        $('#' + nextTabElem.attr('contentid')).addClass('selected');
    }

    $('.EditFeaturedPlace').click(function() {
        selectedPlaceIdEdit = $(this).attr('placeid');
        GenericModal.open("Featured Place", null, null, null /* no callback */);
        $.get('/featuredplaces/GetFeaturedPlaceInfo', { placeId: selectedPlaceIdEdit }, function(data) {
            $('#FeaturedPlaceData').html(data);
        });
    });

}();