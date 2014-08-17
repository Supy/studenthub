$(function(){

	//always activate first tab
	$('#myTab a:eq(1)').tab('show');

	//make text area bigger
	var textarea_height = $('textarea.expand').height();
    $('textarea.expand').focus(function () {
        $(this).animate({ height: "400px" }, 500);
    });    
    $('textarea.expand').focusout(function () {
        $(this).animate({ height: textarea_height }, 500);
    });
    
    $('[data-toggle="tooltip"]').tooltip();
    
    //the login modals
    $('#modalLogin').on('show.bs.modal', function () {
        $('#modalSignup').modal('hide');
    });
    
    $('#modalForgot').on('show.bs.modal', function () {
        $('#modalLogin').modal('hide');
    });
});