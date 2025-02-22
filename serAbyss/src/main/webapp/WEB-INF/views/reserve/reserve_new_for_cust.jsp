<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<link rel="stylesheet" href = "https://www.w3schools.com/w3css/4/w3.css">
<section class="page-section">
	<div class="container">
	
		<form method="post">
			<input type = "hidden" name = "reserve_status" value = "예약완료">
			<input type = "hidden" name = "reserve_custId" value = "${login.person_id }">
			<input type = "hidden" name = "reserve_name" value = "${login.person_name }">
			<input type = "hidden" name = "reserve_phone" value = "${login.person_phone }">
			
			<input  type = "hidden" id = "realReserveAddress" name = "reserve_address" value = "${login.person_address }">
			<table class = "table dataTable-table">
				<tr>
					<td><textarea class="form-control" name="reserve_content" required>모델명: </textarea></td>
				</tr>
				<tr>
					<td>
						<div>
							<input type = "text" id = "sss" name = "reserveTime_engiId" readonly class="form-control" style = "width: 20%; display: inline;">
							<button id = "engiSearchBtn" class = "btn btn-primary btn-sm" style = "height: 37px; margin-bottom: 3px;">기사 검색하기</button>
						</div>
						
						<div id = "id01" class = "w3-modal">
							<div class = "w3-modal-content w3-card-4">
								<header class = "w3-container w3-teal">
									<span onclick = "document.getElementById('id01').style.display='none'"
									class = "w3-button w3-display-topright">&times;</span>
									<h2>우리 지역의 가까운 전문가를 찾아보세요!</h2>
								</header>
								<div class = "w2-container w3-container" style = "padding-top: 10px; padding-bottom: 10px;"><!-- 기사 검색폼 -->
									<input class = "form-control" type = "text" id = "keyword" name = "keyword" style = "width: 20%; display: inline;">
									<button id = "regionSearchBtn" class = "btn btn-primary btn-sm" style = "height: 37px; margin-bottom: 3px;">지역 검색</button><br>
								</div>
							</div>
						</div>
						
						<div id = "daySelect" class = "hiddenNone" style="margin-bottom:3rem;">
							<h2>날짜 선택</h2>
							<c:forEach var = "j" items = "${dayList }">
								<label><input type="radio" name="reserveTime_day" value="${j }" class="form-check-input">${j }일</label>
							</c:forEach>
						</div>
						
						<div id = "hourSelect" class = "hiddenNone">
							<h2>시간 선택(이미 예약이 되어있는 시간은 비어있습니다)</h2>
							<c:forEach var="i" items="${engiList }">
								<c:forEach var="j" items="${dayList }">
									<c:forEach var="k" items="${reserveTimeList }">
										<c:if test="${k.engiId==i.person_id && k.day==j }">
											<div class = "${i.person_id }day${j } hiddenNone main">
												<label><input type = "radio" name = "reserveTime_hour" value = "${k.hour }" class = "form-check-input">${k.hour }:00</label>
											</div>
										</c:if>
									</c:forEach>
								</c:forEach>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<button class = "btn btn-primary btn-sm" id = "goToSelectAddress">
							<h3>서비스 받을 주소지</h3>
							<p id = "inputAddress">${login.person_address } ></p>
						</button>
						
					</td>
				</tr>
			</table>
			<div id = "id02" class = "w3-modal">
				<div class = "w3-modal-content w3-card-4" style = "width: 30%;">
					<header class = "w3-container w3-teal">
						<span onclick = "document.getElementById('id02').style.display='none'"
						class = "w3-button w3-display-topright">&times;</span>
						<h2>&nbsp;&nbsp;&nbsp;</h2>
					</header>
					<div class = "w3-container" style = "padding-top: 10px; padding-bottom: 10px;">
						<button class = "btn btn-primary btn-sm" id = "originalAddressSelectBtn">
							${login.person_address }
						</button>
						<button class = "btn btn-primary btn-sm" id = "newAddressSearchBtn">+주소지 새로 입력</button>
					</div>
				</div>
			</div>
			<div id = "id03" class = "w3-modal">
				<div class = "w3-modal-content w3-card-4">
					<header class = "w3-container w3-teal">
						<span onclick = "document.getElementById('id03').style.display='none'"
						class = "w3-button w3-display-topright">&times;</span>
						<h2>Modal Header</h2>
					</header>
					<label>주소</label><br>
					<input type="text" id="postcode" placeholder="우편번호" readonly class="form-control" style = "width: 15%; display: inline;">
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class = "btn btn-primary btn-sm" style = "height: 37px; margin-bottom: 3px;"><br>
					<input type="text" id="address" name = "address" placeholder="주소" readonly class="form-control" style = "width: 27%;"><br>
					<input type="text" id="detailAddress" name = "detailAddress" placeholder="상세주소" class="form-control" style = "width: 13.3%; display: inline;">
					<input type="text" id="extraAddress" placeholder="참고항목" readonly class="form-control" style = "width: 13.3%; display: inline;">
					<button class = "btn btn-primary btn-sm" id = "thisAddressSelectBtn" style = "height: 37px; margin-bottom: 3px;">이 주소로 선택</button> <!-- 클릭하는 순간 위 버튼에 innerText하고 모든 모달창 닫기 -->
				</div>
			</div>
			<button class = "btn btn-primary btn-lg" id = "submitBtn" type = "submit" disabled="disabled">다음</button>
		</form>
	</div>
	
</section>

<script>
const content = document.querySelector('textarea[name="reserve_content"]')
const submitBtn = document.getElementById('submitBtn')
let dayFlag = false
let hourFlag = false

$('input[name="reserveTime_day"]').change(function(event){
	console.log($('input[name="reserveTime_day"]:checked').val())
	if($('input[name="reserveTime_day"]:checked').val()) dayFlag = true
	console.log('dayFlag: ' + dayFlag)
	check()
})
$('input[name="reserveTime_hour"]').change(function(){
	console.log($('input[name="reserveTime_hour"]:checked').val())
	if($('input[name="reserveTime_hour"]:checked').val()) hourFlag = true
	console.log('hourFlag: ' + hourFlag)
	check()
})

function check(event){
	if(dayFlag && hourFlag){
		submitBtn.disabled = false
	}
	else{
		submitBtn.disabled = true
	}
}
</script>


<script>
	document.querySelectorAll('input[name="reserveTime_day"]').forEach(input => input.onclick = function(event){
		const reserveTime_engiId = document.querySelector('input[name="reserveTime_engiId"]').value
		const reserveTime_day = event.target.value
		if(reserveTime_day) document.getElementById('hourSelect').classList.remove('hiddenNone')
		classFullName = reserveTime_engiId + 'day' + reserveTime_day
		console.log(classFullName)
		document.querySelectorAll('div.' + 'main').forEach(div => div.classList.add('hiddenNone'))
		document.querySelectorAll('div.' + classFullName).forEach(div => div.classList.remove('hiddenNone'))
	});
</script>
<script>
	document.getElementById('engiSearchBtn').onclick = function(event){
		event.preventDefault()
		
		document.getElementById('id01').style.display='block'
	}
	
	document.getElementById('regionSearchBtn').onclick = function(event){
		event.preventDefault()
		const keyword = document.querySelector('input[name="keyword"]').value
		console.log('keyword: ' + keyword)
		const url = '${cpath}/regionSearch/' + keyword
		const opt = {
				method: 'GET'
		}
		fetch(url, opt).then(resp => resp.json())
		.then(json => {
				if(document.querySelector('table.' + 'engiListTable') != null){
					document.querySelector('table.' + 'engiListTable').remove()
				}
				if(document.querySelector('div.' + 'noEngiComment') != null){
					document.querySelector('div.' + 'noEngiComment').remove()
				}
			if(json != ''){
				//회사명, 이름, 아이디, 활동지역(주소)
				const table = document.createElement('table')
				table.classList.add('engiListTable')
				table.classList.add('table', 'dataTable-table')
				const headTr = document.createElement('tr')
				const nameTh = document.createElement('th')
				const idTh = document.createElement('th')
				const addressTh = document.createElement('th')
				const compTh = document.createElement('th')
				nameTh.innerText = '이름'
				idTh.innerText = '아이디'
				addressTh.innerText = '활동지역'
				compTh.innerText = '소속회사'
				headTr.appendChild(nameTh)
				headTr.appendChild(idTh)
				headTr.appendChild(addressTh)
				headTr.appendChild(compTh)
				table.appendChild(headTr)
				for(let i=0;i<json.length;i++){
					var contentTr = document.createElement('tr')
					var nameTd = document.createElement('td')
					var idTd = document.createElement('td')
					var addressTd = document.createElement('td')
					var compTd = document.createElement('td')
					
					var person_name = json[i].PERSON_NAME
					nameTd.innerText = person_name
					
					var person_id = json[i].PERSON_ID
					idTd.innerText = person_id
					
					var person_address = json[i].PERSON_ADDRESS
					addressTd.innerText = person_address
					
					var person_belong = json[i].PERSON_BELONG
					compTd.innerText = person_belong
					
					
					contentTr.appendChild(nameTd)
					contentTr.appendChild(idTd)
					contentTr.appendChild(addressTd)
					contentTr.appendChild(compTd)
					
					contentTr.id = person_id + i
					console.log('contentTr.id: ' + contentTr.id)
					
					contentTr.addEventListener('click', function(event){
						event.preventDefault()
						const aa = json[i].PERSON_ID
						console.log('sexss: ' + json[i].PERSON_ID)
						select(aa)
					})
					
					table.appendChild(contentTr)
				}
				document.querySelector('div.' + 'w2-container').appendChild(table)
			}
			else{
				const div = document.createElement('div')
				div.classList.add('noEngiComment')
				div.innerText = '검색결과가 없습니다'
				document.querySelector('div.' + 'w2-container').appendChild(div)
			}
			
		})
	}
	
function select(aa){
	document.getElementById('sss').value = aa
	document.getElementById('id01').style.display='none'
	document.getElementById('daySelect').classList.remove('hiddenNone')
}
</script>
<script>
document.getElementById('newAddressSearchBtn').onclick = function(event){
	event.preventDefault()
	document.getElementById('id03').style.display='block'
}

document.getElementById('goToSelectAddress').onclick = function(event){
	event.preventDefault()
	document.getElementById('id02').style.display='block'
}

document.getElementById('originalAddressSelectBtn').onclick = function(event){
	event.preventDefault()
	document.getElementById('id02').style.display='none'
	document.getElementById('realReserveAddress').value = fullAddress
}

document.getElementById('thisAddressSelectBtn').onclick = function(event){
	event.preventDefault()
	const address = document.querySelector('input[name="address"]').value
	const detailAddress = document.querySelector('input[name="detailAddress"]').value
	const fullAddress = address + ' ' + detailAddress
	document.getElementById('id03').style.display='none'
	document.getElementById('id02').style.display='none'
	document.getElementById('inputAddress').innerText = fullAddress
	document.getElementById('originalAddressSelectBtn').innerText = fullAddress
	document.getElementById('realReserveAddress').value = fullAddress
}
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>

<%@ include file="../layout/footer.jsp" %>