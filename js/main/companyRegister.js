$(document).ready(function() {
	$("#find-work").on("click", function() {
		findWorkCode();
	});
});

$(document).ready(function() {
	$("#find-bank").on("click", function() {
		findBankCode();
	});
});

function findBankCode() {
	const width = 584;
	const height = 400;
	const left = (screen.width - width) / 2;
	const top = (screen.height - height) / 2;
	const features = `width=${width},height=${height},left=${left},top=${top}`;

	window.open('../findBank.jsp', '_blank', features);
}

function findWorkCode() {
	const width = 584;
	const height = 400;
	const left = (screen.width - width) / 2;
	const top = (screen.height - height) / 2;
	const features = `width=${width},height=${height},left=${left},top=${top}`;

	window.open('../findWork.jsp', '_blank', features);
}

function receiveBankInfo(bankCode, bankName) {
	document.getElementById("bankCode").value = bankCode;
	document.getElementById("bankName").value = bankName;
}

function receiveWorkInfo(workCode, workName) {
	console.log(workCode + workName);
	document.getElementById("workCode").value = workCode;
	document.getElementById("workName").value = workName;
}