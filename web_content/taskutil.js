jQuery(function($) {
	var xhr = jQuery.ajaxSettings.xhr();	
     $('#start').click(function() {
		$('#taskComplete').html("");		
		xhr.open('POST', 'reverse-ajax', true);
		var params = 'taskTime='+$('#taskTime').val()+'&taskName='+$('#taskName').val();
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.setRequestHeader("Content-length", params.length);
        xhr.onreadystatechange = xhrReadyCallBack;		
		xhr.send(params);			
    });	
	function taskStatusChecker(){       
		xhr.open('GET', 'reverse-ajax', true);
        xhr.onreadystatechange = xhrReadyCallBack;
        xhr.send();
    }
	function xhrReadyCallBack() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			if(xhr.responseText == "TIMEOUT"){	
				$('#taskComplete').html("Still processing ....");			
				taskStatusChecker();
			} else {               
				console.log(xhr.responseText);				
				updateReportStatus(xhr.responseText);
			}
		} else if(xhr.readyState == 4){
				alert("Error" + xhr.status);
		}		
	}
	function updateReportStatus(msg){		
		$('#taskComplete').html(msg);		
	}
});
