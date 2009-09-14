
$(document).ready(function() {
	$("#infinite").scrollable({size: 3}).circular();
});

function showImage() {
    $("#basic-modal-content").modal({onOpen: function (dialog) {
		dialog.overlay.fadeIn('slow', function () {
			dialog.container.slideDown('slow', function () {
				dialog.data.fadeIn('slow');
			});
		});
	}});
	
	$("#basic-modal-content").html('<img src="http://farm4.static.flickr.com/3089/2796719087_c3ee89a730.jpg"/>')
};