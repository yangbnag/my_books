// 장르리스트 불러오기
function showGenreList() {
    console.log(url);

    fetch(url)
    .then(res => res.json())
    .then(genreDtoList => {
        console.log(genreDtoList);
        makeGenreDom(genreDtoList);
    });

}

// 장르 돔 생성
function makeGenreDom(genreDtoList){

    // 추가할 위치 가져오기
    const genreSetting = document.querySelector('#genreSetting');

    // 장르 리스트 분해해서 값 넣어주기

    let tag = '';
    let rowNum = 0;
    for (let key in genreDtoList) {

        let genreId = genreDtoList[key].genreId;
        let genreName = genreDtoList[key].genreName;
        let totalGenre = genreDtoList[key].genreTotal;
//        let rowNum = genreList[key].rowNum;

        console.log(genreId);
        console.log(genreName);
        console.log('rowNum : ', rowNum);
        let loop = +key + 1;
        // 태그생성

        tag += `<div id="genList">
                    <div class="genreId" id="genreId` + genreId +`">
                        <input type="hidden" value="` + genreId+ `">
                        <span>` + loop + `</span>
                    </div>
                    <div class="genreName" id="genreName">
                        <span>` + genreName + `</span>
                    </div>
                    <div class="genreTotal">
                        <span> ( ` + totalGenre + ` ) </span>
                    </div>
                    <div class="modiNdel" id="modiNdel">
                        <button type="button" id="genModi" class="btn btn-primary">수정</button>
                        <button type="button" id="gendel" class="btn btn-danger">삭제</button>
                    </div>
                </div>`

                
        // document.getElementById('genreSetting').innerHTML = tag;
        
        console.log('key : ', key);
    }
    genreSetting.innerHTML = tag;



}


let genreNameHTMLBackUp;
let btnHTMLBackUp;
// 수정 삭제 이벤트
function ModifyAndRemoveEvent() {
    const $genreSetting = document.getElementById('genreSetting');

    $genreSetting.addEventListener('click', function(e){
        
        console.log(e.target);
        // 백업
        // genreNameHTMLBackUp = e.target.parentElement.parentElement;
        // btnHTMLBackUp = e.target.parentElement;
        // console.log('genreNameHTMLBackUp : ', genreNameHTMLBackUp);
        // console.log('btnHTMLBackUp : ', btnHTMLBackUp);
        let genreNameBackUp;
        clickeventHandler(e);

    });
}


// 장르 클릭이벤트 핸들러
function clickeventHandler(e){

    e.preventDefault();
    const genreId = e.target.parentElement.parentElement.firstElementChild.firstElementChild.value;
    // const genreId = e.target.parentElement.parentElement.firstElementChild.firstElementChild.innerText;

    console.log('장르 수정 - genreId: ', genreId);
    // console.log(event);

    // genreId === +1일때 수정/삭제 막기
    if (+genreId === +1){
        alert('수정/삭제 할 수 없는 장르입니다.')
    } else {
        console.log('else');

        // 1. 장르 아이디 가져오기 (그대로 들어옴)
        // 장르 아이디로 거슬러 올라가기? -> 장르 id에 장르 번호 붙여서 잡아오는걸로 수정
        const genID = document.getElementById('genreId' + genreId).parentElement;
        // 버튼 변경
        console.log(genID);

        // console.log('genrehtmlBackUp :', genrehtmlBackUp);
        const genreName = genID.firstElementChild.nextElementSibling;
        console.log('clickeventHandler genreName : ', genreName);
        // 2. 장르 이름 백업 -> 수정 취소시 넘겨주기
        genreNameBackUp = genreName.firstElementChild.innerText;
        console.log('genreNameBackUp H :', genreNameBackUp);

        const genreBtn = genID.lastElementChild;

        console.log('genreId : ', genreId);

        if(e.target.matches('#genModi')){
            // alert('genModi');
            genreModify(e, genreName, genreNameBackUp, genreBtn);

        } else if(e.target.matches('#gendel')){
            // alert('gendel');
            genreDelete(genreId);

        } else if(e.target.matches('#modiSaveBtn')){
            // const genreId = e.target.parentElement.parentElement.firstElementChild.innerText;
            console.log('ModifyAndRemoveEvent  modiSaveBtn : ', genreId);
            genreModifySave(genreId);
            // 비동기 요청 전송! -> 비동기 요청 담을거

        } else if(e.target.matches('#modiResetBtn')){
            genreModiCancelBtn(genreName, genreBtn, genreNameBackUp);
        }

    }


}

// 장르수정 비동기 요청전송
function genreModifySave(genreId) {
    
    // const genreInputValue = genreName.value();
    // console.log(genreInputValue);
    const myPageGenreInput = document.getElementById('myPageGenreInput').value;

    console.log('myPageGenreInput : ', myPageGenreInput);

    // 요청정보 담기
    const objj = {

            "genreId": genreId,
            "account": account ,
            "genreName": myPageGenreInput

    };
    console.log(objj);
    

    const reqInfo = {
            method: 'PUT',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(objj)
        };

    console.log(reqInfo);
    
    console.log(delModiURL + '/' + genreId);

    fetch(delModiURL + '/' + genreId, reqInfo)
        .then(res => res.text())
        .then(msg => {
            console.log(msg);
            if(msg === 'modi-success'){
                alert('수정성공!');
                showGenreList();
            } else {
                alert('수정실패');
            }

        });



}

// 장르 수정 취소
function genreModiCancelBtn(genreName, genreBtn, genreNameBackUp) {

    const genreNameHTML = genreName.firstChild;
    console.log('genreNameHTML : ', genreNameHTML);
    
    // 1. 이전 버튼 + 저장 화면으로 돌아가기
    genreNameHTML.innerHTML = '';
    genreNameHTML.innerHTML = genreNameBackUp;
    
    // 2. 버튼 되돌리기
    const genreBtnHTML = genreBtn; 
    console.log('genreBtnHTML : ', genreBtnHTML);
    genreBtnHTML.innerHTML = '';

    genreBtnHTML.innerHTML = ` 
        <button type="button" id="genModi" class="btn btn-primary">수정</button>
        <button type="button" id="gendel" class="btn btn-danger">삭제</button>
    `;

    showGenreList();
}


// 장르 수정버튼 클릭시 화면 랜더링
function genreModify(e, genreName, genreNameBackUp, genreBtn) {
    

    // 3. 수정버튼 클릭시 장르 아이디 위치를 그대로 input청으로 바꿔주기
    // genreName 삭제
    genreName.innerHTML = "";
    genreBtn.innerHTML = "";
    
    // tag값 넣어주기 + input에 값 그대로 넣어주기
    tag = `<input type="text" id="myPageGenreInput" value="`+ genreNameBackUp +`">`;

    btnTag = `
                <button type="button" class="btn btn-info" id="modiSaveBtn">저장</button>
                <button type="button" class="btn btn-danger" id="modiResetBtn">취소</button>
                `;

    genreName.innerHTML += tag ; 
    genreBtn.innerHTML += btnTag;
    
    // 수정
    // 저장버튼 누르면 수정사항 저장
    // 리스트 다시 조회


}


// 장르 삭제
function genreDelete(genreId) {
    
    console.log('장르 삭제 - genreId : ', genreId);

    if (!confirm('선택하신 장르를 삭제하시겠습니까?')) return;

    fetch(delModiURL + '/' + genreId, {
        method: 'DELETE'
    })
        .then(res => res.text())
        .then(msg => {
            if (msg === 'del-success') {
                alert('삭제 성공!');
                // 목록 새로불러오기 -> 오ㅐ 두번 실행되는거지?
                showGenreList();
                console.log('delete - showGenreList');
            } else {
                alert('삭제 실패!!');
            }
        });

}




// 함수 실행부
(function(){

    console.log('함수실행부');
    showGenreList();
    ModifyAndRemoveEvent();

})()