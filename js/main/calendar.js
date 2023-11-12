function mapEvent(eventData) {
	var color;
	switch (eventData.type) {
		case 0: //개인
			color = 'blue';
			break;
		case 1: //부서공통
			color = 'red';
			break;
		case 2: //전체공통
			color = 'green';
			break;
		default:
			color = 'blue'; // 기본 색상
	}
	return {
		title: eventData.subject,
		start: eventData.start,
		end: eventData.end,
		color: color,
		textColor: 'white',
		extendedProps: {
			content: eventData.content,
			eventId: eventData.id,
			userId: eventData.userId,
			type: eventData.type
		}
	};
}

function formatDateToYYYYMMDDHHMMSS(date) {
	// 날짜 포맷을 YYYY-MM-DD hh:mm:ss로 변경
	var yyyy = date.getFullYear();
	var mm = (date.getMonth() + 1).toString().padStart(2, '0');
	var dd = date.getDate().toString().padStart(2, '0');
	var hh = date.getHours().toString().padStart(2, '0');
	var mi = date.getMinutes().toString().padStart(2, '0');
	var ss = '00';

	return `${yyyy}-${mm}-${dd} ${hh}:${mi}:${ss}`;
}

document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var eventId = document.getElementById('eventId');
	var userId = document.getElementById('userId');
	var eventModal = document.getElementById('eventModal');
	var modalTitle = document.getElementById('modalTitle');
	var modalContent = document.getElementById('modalContent');
	var modalStartDate = document.getElementById('modalStartDate');
	var modalEndDate = document.getElementById('modalEndDate');
	var closeButton = document.querySelector('.close-button');
	var type = document.querySelector('.calendar-select');

	closeButton.addEventListener('click', function() {
		eventModal.style.display = 'none';
	});

	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView: 'dayGridMonth',
		height: 600,
		eventClick: function(info) {
			modalTitle.value = info.event.title;
			modalContent.value = info.event.extendedProps.content;
			eventId.textContent = info.event.extendedProps.eventId;
			userId.value = info.event.extendedProps.userId;
			modalStartDate.value = formatDateToYYYYMMDDHHMMSS(info.event.start);
			modalEndDate.value = (info.event.end ? formatDateToYYYYMMDDHHMMSS(info.event.end) : '');
			type.value = info.event.extendedProps.type;
			$('select[name=calendar-type]').val(type.value.toString()).prop("selected", true);

			eventModal.style.display = 'block'; // 모달을 보여줌

			info.jsEvent.preventDefault(); // 기본 이벤트 핸들러 방지
		}

	});

	$.ajax({
		type: "get",
		url: "/ERFlow/calendar/view",
		dataType: "json",
		success: function(data) {
			console.log(data);
			var events = data.map(mapEvent);

			calendar.addEventSource(events);

			calendar.render();
		},
		error: function(xhr) {
			console.log(xhr);
		}
	});

	var deleteButton = document.querySelector('#delete-button');

	deleteButton.addEventListener('click', function() {
		var deleteEventId = eventId.textContent;
		var deleteUserId = userId.value;
		console.log(deleteEventId);
		console.log(deleteUserId);

		if (confirm('이 이벤트를 삭제하시겠습니까?')) {
			$.ajax({
				type: "post",
				url: "/ERFlow/calendar/delete",
				data: JSON.stringify({
					eventId: deleteEventId,
					userId: deleteUserId
				}),
				contentType: "application/json",
				success: function(response) {
					console.log('Event deleted:', response);
					window.location.href = window.location.href;
					eventModal.style.display = 'none'; // 모달 창 닫기
					calendar.refetchEvents(); // 이벤트 다시 가져오기
				},
				error: function(xhr) {
					console.log(xhr);
				}
			});
		}
	});

	var updateButton = document.querySelector('#update-button');

	updateButton.addEventListener('click', function() {
		var updateEventId = eventId.textContent;
		var updateUserId = userId.value;
		var subject = modalTitle.value;
		var content = modalContent.value;
		var startDate = modalStartDate.value;
		var endDate = modalEndDate.value;
		var type = modalType.value;
		let flag = true;

		// Date 객체 생성
		let startDateObj = new Date(startDate);
		let endDateObj = new Date(endDate);
		
		if (startDateObj >= endDateObj) {
			alert("시작일은 종료일보다 크거나 같게 설정할 수 없습니다.");
			flag = false;
		}
		if (subject == null || subject.trim() == "") {
			alert("제목을 달아주세요.");
			flag = false;
		}
		
		if (flag) {
			if (confirm('이 이벤트를 변경하시겠습니까?')) {
				$.ajax({
					type: "post",
					url: "/ERFlow/calendar/update",
					data: JSON.stringify({
						eventId: updateEventId,
						userId: updateUserId,
						subject: subject,
						content: content,
						startDate: startDate,
						endDate: endDate,
						type: type,
					}),
					contentType: "application/json",
					success: function(response) {
						window.location.href = window.location.href;
						eventModal.style.display = 'none'; // 모달 창 닫기
						calendar.refetchEvents(); // 이벤트 다시 가져오기
					},
					error: function(xhr) {
						console.log(xhr);
					}
				});
			}
		} 
	});
});