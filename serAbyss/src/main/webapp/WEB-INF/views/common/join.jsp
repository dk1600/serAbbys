<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>


<link rel = "stylesheet" href = "https://www.w3schools.com/w3css/4/w3.css">
<div>
<h2>회원가입 폼</h2>
<form id = "joinForm" method = "post">

	<p>
		<label><input class = "indi" type = "radio" name = "person_check" value = "n" checked>개인회원</label>
		<label><input class = "company" type = "radio" name = "person_check" value = "y">법인회원</label>
	</p>
	
	<div class = "company main hiddenNone">
		<label><input type = "radio" name = "any" class = "radio1" >개인사업자</label>
		<label><input type = "radio" name = "any" value = "comp" class = "radio2">법인사업자</label>
		<label><input type = "radio" name = "any" value = "empl" class = "radio3">법인소속직원(기사)</label>
		
		<div class = "radio2 hiddenNone">
			<h2>법인사업자 폼</h2><!-- 회사명 입력하는 폼 -->
			<input type = "text" name = "person_belong" placeholder="회사명 입력">
		</div>
		
		<div class = "radio12 hiddenNone">
			<h2>사업자등록번호 입력</h2>
			<input type = "text" name = "person_busiNum">
		</div>
		
		<div class = "radio3 hiddenNone">
			<h2>법인소속직원(기사) 폼</h2><!-- compList에서 검색하는 폼 -->
			<input type = "text" id = "person_belong" name = "person_belong" readonly>
			<button onclick = "document.getElementById('id01').style.display='block'"
			class = "w3-button w3-black">회사 검색</button>
		</div>
		
		<div id = "id01" class = "w3-modal">
			<div class = "w3-modal-content w3-card-4">
				<header class = "w3-container w3-teal">
					<span onclick = "document.getElementById('id01').style.display='none'"
					class = "w3-button w3-display-topright">&times;</span>
					<h2>Modal Header</h2>
				</header>
				<div class = "w3-container">
					회사 검색 폼<br>
					<input type = "text" id = "keyword" name = "keyword">
					<button id = "compSearchBtn">검색</button><br>
				</div>
			</div>
		</div>
	</div>
	
	<div>
	
		<label>아이디</label><br>
		<input type = "text" id = "person_id" name = "person_id" required>
		<div class = "check_font" id = "id_check"></div>
	
		<label>비밀번호</label><br>
		<input type = "password" id = "person_pw" name = "person_pw" required>
		<div class = "check_font" id = "pw_check"></div>
		
		<label>비밀번호 확인</label><br>
		<input type = "password" id = "person_pw2" name = "person_pw2" required>
		<div class = "check_font" id = "pw2_check"></div>
		
		<label>이름</label><br>
		<input type = "text" id = "person_name" name = "person_name" required>
		<div class = "check_font" id = "name_check"></div>
		
		<label>이메일</label><br>
		<input type = "text" id = "person_email" name = "person_email" required>
		<div class = "check_font" id = "email_check"></div>
		
		<label>생년월일 ex)980819</label><br>
		<input type = "text" id = "person_birth" name = "person_birth" required>
		<div class = "check_font" id = "birth_check"></div>
		
		<label>일반전화</label><br>
		<input type = "text" name = "person_call">
		<div class = "check_font" id = "call_check"></div>
		
		<label>팩스</label><br>
		<input type = "text" name = "person_fax">
		<div class = "check_font" id = "fax_check"></div>
		
		<p><input type = "text" name = "person_phone" placeholder="핸드폰번호 입력" required><button>인증번호 받기</button></p>
		
		<div>
			<label>주소</label><br>
			<input type="text" id="postcode" placeholder="우편번호">
			<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="address" name = "address" placeholder="주소"><br>
			<input type="text" id="detailAddress" name = "detailAddress" placeholder="상세주소">
			<input type="text" id="extraAddress" placeholder="참고항목">
		</div>
	</div>
	
	<button type = "submit" id = "reg_submit">회원가입</button>
</form>
</div>

<script>
document.getElementById('compSearchBtn').onclick = function(event){
	const keyword = document.getElementById('keyword').value
	const url = '${cpath}/compSearch/' + keyword
	const opt = {
			method: 'GET'
	}
	fetch(url, opt).then(resp => resp.json())
	.then(json => {
			if(document.querySelector('table.' + 'compListTable') != null){
				document.querySelector('table.' + 'compListTable').remove()
			}
			if(document.querySelector('div.' + 'noCompComment') != null){
				document.querySelector('div.' + 'noCompComment').remove()
			}
		if(json != ''){
			
			const table = document.createElement('table')
			table.classList.add('compListTable')
			const headTr = document.createElement('tr')
			const nameTh = document.createElement('th')
			const addressTh = document.createElement('th')
			nameTh.innerText = '회사 이름'
			addressTh.innerText = '회사 주소'
			headTr.appendChild(nameTh)
			headTr.appendChild(addressTh)
			table.appendChild(headTr)
			for(let i=0;i<json.length;i++){
				var contentTr = document.createElement('tr')
				var nameTd = document.createElement('td')
				var addressTd = document.createElement('td')
				
				var companyList_name = json[i].COMPANYLIST_NAME
				var nameLink = document.createElement('a')
				nameLink.innerText = companyList_name
				nameLink.href = "javascript:inputBelong('" + companyList_name + "')"
				nameTd.appendChild(nameLink)
				
				var companyList_address = json[i].COMPANYLIST_ADDRESS
				var addressLink = document.createElement('a')
				addressLink.innerText = companyList_address
				addressLink.href = "javascript:inputBelong('" + companyList_name + "')"
				addressTd.appendChild(addressLink)
				
				contentTr.appendChild(nameTd)
				contentTr.appendChild(addressTd)
				
				table.appendChild(contentTr)
			}
			document.querySelector('div.' + 'w3-container').appendChild(table)
		}
		else{
			const div = document.createElement('div')
			div.classList.add('noCompComment')
			div.innerText = '검색결과가 없습니다'
			document.querySelector('div.' + 'w3-container').appendChild(div)
		}
		
	})
};
</script>

<script>
function inputBelong(companyList_name){
	console.log(companyList_name)
	document.getElementById('person_belong').value = companyList_name
	document.getElementById('id01').style.display='none'
}
</script>

<script>

//아이디 중복체크
$('#person_id').blur(function(){
	const idJ = /^[a-z0-9]{4,12}$/
	const person_id = $('#person_id').val()
	$.ajax({
		url: '${cpath}/common/idCheck?person_id=' + person_id,
		type: 'get',
		success: function(data){
			if(idJ.test(person_id)){
				if(data == 1){
					$('#id_check').text('이미 사용중인 아이디입니다')
					$('#id_check').css('color', 'red')
				}
				else{
					$('#id_check').text('사용 가능한 아이디입니다')
					$('#id_check').css('color', 'blue')
				}
			}else if(!idJ.test(person_id)){
				$('#id_check').text('아이디는 소문자와 숫자 4~12자리만 가능합니다')
				$('#id_check').css('color', 'red')
			}
		}, error: function(){
			console.log('실패')
		}
	})
})

//비밀번호 체크
$('#person_pw').blur(function(){
	const pwJ = /^[a-z0-9]{6,20}$/
	const person_pw = $('#person_pw').val()
	const person_pw2 = $('#person_pw2').val()
		if(pwJ.test(person_pw)){
			$('#pw_check').text('사용 가능한 비밀번호입니다')
			$('#pw_check').css('color', 'blue')
// 			$('#reg_submit').attr('disabled', false)
		} else if(person_pw == ''){
			$('#pw_check').text('비밀번호를 입력해주세요')
			$('#pw_check').css('color', 'red')
// 			$('#reg_submit').css('disabled', true)
		} else {
			$('#pw_check').text('비밀번호는 소문자와 숫자 6~20자리만 가능합니다')
			$('#pw_check').css('color', 'red')
// 			$('#reg_submit').attr('disabled', true)
			
		}
})
//비밀번호 확인 체크
$('#person_pw2').blur(function(){
	const person_pw = $('#person_pw').val()
	const person_pw2 = $('#person_pw2').val()
	if(person_pw2 != person_pw){
			$('#pw2_check').text('비밀번호가 일치하지 않습니다')
			$('#pw2_check').css('color', 'red')
	}else{
			$('#pw2_check').text('비밀번호가 일치합니다')
			$('#pw2_check').css('color', 'blue')
	}
})

//이름 체크
$('#person_name').blur(function(){
	const person_name = $('#person_name').val()
	if(person_name == ''){
			$('#name_check').text('이름을 입력하세요')
			$('#name_check').css('color', 'red')
	}else{
			$('#name_check').text('')
		
	}
})

//이메일 체크
$('#person_email').blur(function(){
	const emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	const person_email = $('#person_email').val()
	$.ajax({
		url: '${cpath}/common/emailCheck?person_email=' + person_email,
		type: 'get',
		success: function(data){
			if(emailJ.test(person_email)){
				if(data == 1){
					$('#email_check').text('이미 사용중인 이메일입니다')
					$('#email_check').css('color', 'red')
				}
				else{
					$('#email_check').text('사용 가능한 이메일입니다')
					$('#email_check').css('color', 'blue')
				}
			}else if(!emailJ.test(person_email)){
				$('#email_check').text('이메일 형식에 적합하지 않습니다')
				$('#email_check').css('color', 'red')
			}
		}, error: function(){
			console.log('실패')
		}
	})
})

//생년월일 체크
//보류
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

<script>
	document.querySelectorAll('p > label > input').forEach(input => input.onclick = function(event){
		const className = event.target.className
		console.log(className)
		if(className == 'company'){
			document.querySelector('div.' + className).classList.remove('hiddenNone')
		}
		if(className == 'indi'){
			document.querySelector('div.' + 'company').classList.add('hiddenNone')
		}
	})
	
	document.querySelectorAll('div > label > input').forEach(input => input.onclick = function(event){
		const className = event.target.className
		
		if(className == 'radio1'){
			document.querySelector('div.' + 'radio12').classList.remove('hiddenNone')
			document.querySelector('div.' + 'radio2').classList.add('hiddenNone')
			document.querySelector('div.' + 'radio3').classList.add('hiddenNone')
		}
		if(className == 'radio2'){
			document.querySelector('div.' + 'radio12').classList.remove('hiddenNone')
			document.querySelector('div.' + 'radio2').classList.remove('hiddenNone')
			document.querySelector('div.' + 'radio3').classList.add('hiddenNone')
		}
		if(className == 'radio3'){
			document.querySelector('div.' + 'radio12').classList.add('hiddenNone')
			document.querySelector('div.' + 'radio3').classList.remove('hiddenNone')
			document.querySelector('div.' + 'radio2').classList.add('hiddenNone')
		}
	})
	
</script>

<%@ include file="../layout/footer.jsp"%>