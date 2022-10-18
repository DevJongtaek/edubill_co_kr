/* Demo Note:  This demo uses a FileProgress class that handles the UI for displaying the file name and percent complete.
The FileProgress class is not part of SWFUpload.
*/


/* **********************
   Event Handlers
   These are my custom event handlers to make my
   web application behave the way I went when SWFUpload
   completes different tasks.  These aren't part of the SWFUpload
   package.  They are part of my application.  Without these none
   of the actions SWFUpload makes will show up in my application.
   ********************** */
function preLoad() {
	if (!this.support.loading) {
		alert("You need the Flash Player 9.028 or above to use SWFUpload.");
		return false;
	}
}
function loadFailed() {
	alert("Something went wrong while loading SWFUpload. If this were a real application we'd clean up and then give you an alternative");
}

function fileQueued(file) {
	try {
	} catch (ex) {
		this.debug(ex);
	}

}

function fileDialogComplete() {
	this.startUpload();
}

function uploadStart(file) {
	
	try {
		document.getElementById("progress").style.display = "block";
		document.getElementById("describe").style.display = "none";
		this.customSettings.progressCount = 0;
		updateDisplay.call(this, file);
	}
	catch (ex) {
		this.debug(ex);
	}
	
}

function uploadProgress(file, bytesLoaded, bytesTotal) {
	try {
		this.customSettings.progressCount++;
		updateDisplay.call(this, file);
	} catch (ex) {
		this.debug(ex);
	}
	
}

function uploadSuccess(file, serverData) {
	try {

		updateDisplay.call(this, file);

		var sData = serverData.split(",");

		totalUpCount++;
		var img_path = opener.set_editor.config.path + opener.set_editor.config.pdspath + '/' + opener.set_editor.config.imagepath;
		$("#upload_image_" + totalUpCount).html('<img src="' + img_path + sData[0] + '" width="90" height="90">');
		uploadArr[totalUpCount] = sData[0] + "," + sData[1] + "," + sData[2] + "," + sData[3];

		document.getElementById("progress").style.display = "none";

	} catch (ex) {
		this.debug(ex);
	}
}

function uploadComplete(file) {

}

function updateDisplay(file) {

	this.customSettings.tx_upload_progress_grp.style.width = SWFUpload.speed.formatPercent(file.percentUploaded);
	this.customSettings.tx_upload_progress_grp.innerHTML = SWFUpload.speed.formatPercent(file.percentUploaded);
}

function fileQueueError(file, errorCode, message)  {
	try {
		// Handle this error separately because we don't want to create a FileProgress element for it.
		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
			alert("You have attempted to queue too many files.\n" + (message === 0 ? "You have reached the upload limit." : "You may select " + (message > 1 ? "up to " + message + " files." : "one file.")));
			return;
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			alert("The file you selected is too big.");
			this.debug("Error Code: File too big, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			return;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			alert("The file you selected is empty.  Please select another file.");
			this.debug("Error Code: Zero byte file, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			return;
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			alert("The file you choose is not an allowed file type.");
			this.debug("Error Code: Invalid File Type, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			return;
		default:
			alert("An error occurred in the upload. Try again later.");
			this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			return;
		}
	} catch (e) {
	}
}

function getFileSize(size){

	if (size > 1048576){
		val = getRound(((size / 1048576) * 1000 / 1000),1) + " MB";
	}else if (size > 1024) {
		val = getRound(((size / 1024) * 10 / 10),1) + " KB";
	}else{
		val = size + " Byte";
	}

	return val;

}

function getRound(val, precision) { 
	val = val * Math.pow(10,precision); 
	val = Math.round(val); 
	return val/Math.pow(10,precision); 
}