// 썸네일 선택 후 랜더링, 히든인풋 만드는 함수
function showThumbImg(fileName, fileOriginName) {
    // console.log('showThumbImg 함수 호출 : ', fileName);
    // console.log('showThumbImg 함수 호출 : ', fileOriginName);

    // 썸네일 랜더링
    const $thumbImg = $('.thumb-img');
    // console.log($thumbImg.length);
    // 등록된 썸네일이 없을 때
    if ($thumbImg.length <= 0) {
        $('#reg-1 .box-msg').addClass('hide');

        // 이미지 랜더링
        const $img = document.createElement('img');
        $img.classList.add('post-img');
        $img.classList.add('thumb-img');
        $img.setAttribute('src', '/loadFile?fileName=' + fileName);
        $img.setAttribute('alt', fileOriginName);
        $('#reg-1 .img-box').append($img);

        // 등록 때 썸네일 경로 보내는 히든인풋
        const $thumbFileName = document.createElement('input');
        $thumbFileName.classList.add('thumbFileName-hidden-input');
        $thumbFileName.setAttribute('type', 'hidden');
        $thumbFileName.setAttribute('name', 'thumbFileName');
        $thumbFileName.setAttribute('value', fileName);
        $('#reg-1 .img-box').append($thumbFileName);


    }
    // 등록된 썸네일이 있을 때
    else {
        // 이미지 주소 교체
        $thumbImg.attr('src', '/loadFile?fileName=' + fileName);
        $thumbImg.attr('alt', fileOriginName);

        // 등록 때 썸네일 경로 보내는 히든인풋 교체
        $('.thumbFileName-hidden-input').attr('value', fileName);
    }

    // 박스에 파일이름 띄우기
    $('#reg-1 .file-box-right').text(fileOriginName)
}


// 첨부파일 선택 후 랜더링, 히든인풋 만드는 함수
function showImgs(fileNames) {
    // console.log('showImgs 함수 호출 : ', fileNames);

    for (const fileName of fileNames) {

        // 부모 div (이미지, 삭제 버튼, 히든인풋)
        const $imgBox = document.createElement('div');
        $imgBox.classList.add('upload-img-box');

        // 화면에 보여줄 이미지
        const $img = document.createElement('img');
        $img.classList.add('upload-img');
        $img.setAttribute('src', '/loadFile?fileName=' + fileName);

        // 삭제 버튼
        const $delBtn = document.createElement('span');
        $delBtn.classList.add('fas', 'fa-times-circle', 'upload-cancel-btn');

        // 등록 때 이미지 경로 보내줄 히든인풋
        const $imgFileName = document.createElement('input');
        $imgFileName.setAttribute('type', 'hidden');
        $imgFileName.setAttribute('name', 'fileNames');
        $imgFileName.setAttribute('value', fileName);


        // 어펜드
        $imgBox.append($img);
        $imgBox.append($delBtn);
        $imgBox.append($imgFileName);
        $('#reg-6 .uploaded-list').append($imgBox);
    }

    // 파일선택창 메시지 세팅
    setUploadCount();
}


// 파일 확장자가 이미지 확장자가 맞으면 true 리턴
function isImageFile(originFileName) {
    const pattern = /jpg$|gif$|png$|jfif$|jpeg$/i;
    return originFileName.match(pattern);
}

// 최하단 파일 선택창 메세지 세팅해주는 함수
function setUploadCount() {
    const upImgCnt = $('.upload-img').length;
    // console.log(upImgCnt);
    if (upImgCnt === 0) {
        $('.upload-msg').text("현재 첨부한 이미지가 없습니다.");
    } else {
        $('.upload-msg').text("첨부 이미지 " + upImgCnt + "개");
    };
}

// 첨부 이미지 삭제하는 함수
function delUploadImg(e) {
    // console.log("삭제 이벤트 호출");
    // 안내 메세지 돌려놓기
    $('.files-msg').css('color', '#555');
    $target = e.target;

    if (!$target.classList.contains('upload-cancel-btn')) {
        return;
    }
    // 타깃 부모 노드 삭제(랜더링 이미지, 히든인풋 포함)
    $target.parentElement.remove();
    // 파일 선택창 메세지 다시 세팅
    setUploadCount()
}


// 썸네일 인풋에 파일 올렸을 때(파일 하나)
// 서버에 업로드하고 다시 렌더링해오는 비동기 이벤트
function uploadAndRendeThumbnail(e) {
    // console.log('체인지 이벤트 작동!');
    // 선택된 파일 정보를 서버로 전송
    // 1. 드롭된 파일 데이터 읽기
    const files = e.originalEvent.target.files;
    // console.log('input file data: ', files);

    // 파일 오리지널 이름
    const fileOriginName = files[0].name;
    // console.log('fileOriginName : ', fileOriginName);

    // 파일이 이미지가 아니라면 이벤트 종료
    if (!isImageFile(fileOriginName)) {
        alert('이미지 파일만 업로드 가능합니다.');
        return;
    }

    // 2. 읽은 파일 데이터를 input[type=file]태그에 저장
    const $fileInput = $('#ajax-file');
    $fileInput.prop('files', files); // 첫번째 파라미터는 input의 name 속성과 맞추기
    // console.log($fileInput[0].files);

    // 3. 파일 데이터를 비동기 전송하기 위해서는 FormData객체가 필요
    const formData = new FormData();
    // 4. 전송할 파일들을 전부 FormData안에 포장
    for (let file of $fileInput[0].files) {
        formData.append('files', file);
    }

    // 5. 비동기 요청 전송
    const reqInfo = {
        method: 'POST',
        body: formData
    };
    fetch('/ajax-upload', reqInfo)
        .then(res => {
            // console.log(res.status);
            return res.json();
        })
        .then(fileNames => {
            // console.log(fileNames);
            showThumbImg(fileNames, fileOriginName);
        });
}


// 첨부이미지 인풋에 파일 올렸을 때(파일 여러 개)
// 서버에 업로드하고 렌더링하는 비동기 이벤트
function uploadAndRendeFiles(e) {
    // 첨부 파일 정보를 서버로 전송
    // 1-1. 선택된 파일 데이터 읽기
    const files = e.originalEvent.target.files;
    
    // 1-2.첨부 이미지 총 합이 5 이상이면 리턴
    const uploadFilesNum = files.length;    // 새로 업로드할 파일 수
    const uploadedFileNum = $('.uploaded-list')[0].children.length; // 기존에 업로드되어 있는 파일 수
    const total = uploadFilesNum + uploadedFileNum;

    if(total > 5){
        alert('첨부 이미지는 5개까지 등록 가능합니다.');
        $('.files-msg').css('color', '#f44659');
        return;
    } else {
        $('.files-msg').css('color', '#555');
    }

    // 원본 이름 배열
    const originNames = [];
    // 1-3. 이미지 파일이 아니면 리턴
    for (const f of files) {
        if (!isImageFile(f.name)) {
            alert('이미지 파일만 업로드 가능합니다.');
            return;
        }
        originNames.push(f.name);
    }
    // console.log(originNames);

    // 2. 읽은 파일 데이터를 input[type=file]태그에 저장
    const $fileInput = $('#ajax-file-multi');
    // console.log($fileInput[0].files);

    // 3. 파일 데이터를 비동기 전송하기 위해서는 FormData객체가 필요
    const formData = new FormData();

    // 4. 전송할 파일들을 전부 FormData안에 포장
    for (let file of $fileInput[0].files) {
        formData.append('files', file);
    }
    // console.log(formData);

    // 5. 비동기 요청 전송
    const reqInfo = {
        method: 'POST',
        body: formData
    };
    fetch('/ajax-upload', reqInfo)
        .then(res => {
            // console.log(res.status);
            return res.json();
        })
        .then(fileNames => {
            // console.log(fileNames);
            showImgs(fileNames);
        });
}