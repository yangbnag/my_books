<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>ibini books</title>

    <!-- reset css -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">

    <!-- fontawesome css: https://fontawesome.com -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">

    <!-- linear icons -->
    <!-- https://linearicons.com/free#cdn -->
    <link rel="stylesheet" href="https://cdn.linearicons.com/free/1.0.0/icon-font.min.css">

    <!-- naver font -->
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css" rel="stylesheet">



    <!-- slick css || https://kenwheeler.github.io/slick/  -->
    <link rel="stylesheet" href="/css/slick-1.8.1.css">

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- custom css -->
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/post-reg.css">
    <link rel="stylesheet" href="/css/platform.css" />


    <!-- jquery -->
    <script src="/js/jquery-3.3.1.min.js"></script>


    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <!-- custom js -->
    <script src="/js/common.js" defer></script>
    <script src="/js/post-reg.js" defer></script>
    <script src="/js/post-platformAndGenre.js" defer></script>
    <script src="/js/upload.js" defer></script>


</head>

<body>

    <!-- header -->
    <%@ include file="../include/change-header.jsp" %>

    <div id="wrap">


        <!-- ??? ????????? ?????? ?????? -->
        <section class="post-reg-section">
            <div class="top-msg">* ?????? ?????? ?????? <br>?????? ????????? ???????????? ????????? ??????????????? ???????????????.(?????? ??????)</div>
            <div class="inner-section">
                <form id="write-form" action="#" method="post" autocomplete="off" enctype="multipart/form-data">

                    <!-- ?????? : ??????-->
                    <input type="hidden" name="account" id="" value="${account}">
                    <!-- ?????? : ???????????? ?????????(????????? ?????? ??????)-->
                    <input type="hidden" name="caId" value="1">
                    <!-- ?????? : favorite (????????? ?????? 0)-->
                    <input type="hidden" name="favorite" value="0">

                    <!-- ?????????, ??????, ??????, ??????-->
                    <div id="reg-1">
                        <!-- ????????? -->
                        <div class="img-wrap">
                            <div class="img-box">
                                <span class="box-msg">???????????? ????????? ?????????</span>
                            </div>
                            <label class="file-box">
                                <div class="file-box-left">
                                    ?????? ??????
                                </div>
                                <div class="file-box-right">
                                    ????????? ???????????? ????????????.
                                </div>
                                <input type="file" name="files" id="ajax-file" class="file-input thumb-input">
                            </label>
                        </div>

                        <!-- ??????, ??????, ?????? -->
                        <div class="tw-wrap">
                            <div class="span-wrap">
                                <span class="reg-span">* ??? ??????</span>
                                <span class="explain-span title-msg"></span>
                            </div>
                            <input class="white-box" type="text" name="postTitle" value="${bookInfo.title}">

                            <div class="span-wrap">
                                <span class="reg-span">* ??????</span>
                                <span class="explain-span writer-msg"></span>
                            </div>
                            <input class="white-box" type="text" name="postWriter" value="${bookInfo.author}">

                            <div class="span-wrap">
                                <span class="reg-span">??????</span>
                                <span class="explain-span star-msg"></span>
                            </div>
                            <input class="white-box" type="text" name="starRate" placeholder="1?????? 9 ????????? ????????? ????????? ?????????"
                                maxlength="1"
                                oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" />
                        </div>
                    </div> <!-- // end reg-1 -->


                    <!-- ?????????, ?????? -->
                    <div id="reg-2">
                        <div class="plge-wrap">
                            <div class="select-container">

                                <div class="platformSelText">
                                    <span class="reg-span">?????????</span>
                                    <span class="platformInputShowEvent">??? ????????? ??????????????? ?????? ??????<i
                                            class="far fa-hand-point-left ms-2"></i></span>
                                </div>

                                <div class="select">
                                    <div class="platformSelBox">
                                        <select name="platformId" id="platformselect">
                                            <option value="#">???????????? ???????????????</option>
                                        </select>
                                    </div>

                                    <div class="platformClick" name="platformAdd">
                                        <input type="text" id="platformInput">
                                        <button id="platformBtn">??????</button>
                                    </div>
                                </div>
                            </div>


                            <div class="genre-container">
                                <div class="genreSelectBox">
                                    <div id="genreClick">
                                        <span class="reg-span">??????</span>
                                        <span class="GenreInputShowEvent">??? ?????? ??????????????? ?????? ??????<i
                                                class="far fa-hand-point-left ms-2"></i></span>
                                    </div>

                                    <div class="genreSelAndInput">
                                        <div class="genreSelectBox">
                                            <select name="genreId" id="genreSelect">
                                                <option value="#">????????? ???????????????</option>
                                            </select>
                                        </div>
                                        <div class="textClick" name="genreAdd">
                                            <input type="text" id="genreInput">
                                            <button id="genreBtn">??????</button>
                                        </div>
                                    </div>

                                </div>

                            </div>



                        </div> <!-- // end plge-wrap -->
                    </div> <!-- // end reg-2 -->


                    <!-- ?????? ??????, ?????? ?????? -->
                    <div id="reg-3">
                        <div class="span-wrap">
                            <span class="reg-span">?????? ??????</span>
                        </div>
                        <div class="radio-wrap pub-btn-group">
                            <label class="white-box radio-item checked">??????
                                <input class="ep-radio" type="radio" name="publishStatus" value="1" checked>
                            </label>
                            <label class="white-box radio-item">??????
                                <input class="ep-radio" type="radio" name="publishStatus" value="2">
                            </label>
                            <label class="white-box radio-item">??????
                                <input class="ep-radio" type="radio" name="publishStatus" value="3">
                            </label>
                        </div>
                        <div class="span-wrap">
                            <span class="reg-span">?????? ??????</span>
                            <span class="explain-span ep-msg"></span>
                        </div>
                        <input class="white-box" type="text" name="publishCycle" placeholder="??????) ???, ???, ??? 10???">
                    </div> <!-- // end reg-3 -->

                    <!-- ?????? ??????, ?????? ??????, ?????? ????????? -->
                    <div id="reg-4">
                        <div class="span-wrap">
                            <span class="reg-span">?????? ??????</span>
                            <span class="explain-span ep-msg"></span>
                        </div>

                        <div class="radio-wrap ep-btn-group">
                            <label class="white-box radio-item checked">
                                <span>??????(???)</span>
                                <input class="ep-radio" type="radio" name="epId" value="0" checked>
                            </label>
                            <label class="white-box radio-item">
                                <span>?????????(p)</span>
                                <input class="ep-radio" type="radio" name="epId" value="1">
                            </label>
                            <label class="white-box radio-item">
                                <span>??????</span>
                                <input class="ep-radio" type="radio" name="epId" value="2">
                            </label>
                            <label class="white-box radio-item">
                                <span>?????????(%)</span>
                                <input class="ep-radio" type="radio" name="epId" value="3">
                            </label>
                        </div>

                        <div class="ep-wrap">
                            <div class="ep-input-wrap">
                                <span class="reg-span">?????? ??????</span> <!-- ????????? ${p.epName}??????-->
                                <input class="white-box" type="text" name="curEp" placeholder="0~99999 ?????? ??????"
                                    maxlength="5"
                                    oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" />
                            </div>
                            <div class="ep-input-wrap">
                                <span class="reg-span">?????? ??????</span> <!-- ????????? ${p.epName}??????-->
                                <input class="white-box" type="text" name="totalEp" placeholder="0~99999 ?????? ??????"
                                    maxlength="5"
                                    oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" />
                            </div>
                        </div>
                    </div>

                    <div id="reg-5">
                        <div class="span-wrap">
                            <span class="reg-span">????????????</span>
                            <span class="explain-span">[ ??? ??????????????? #??? ???????????? ???????????????. ]</span>
                        </div>
                        <input class="white-box" type="text" name="tagName" placeholder="??????) #??????1 #??????_2">
                    </div>

                    <div id="reg-6">
                        <div class="span-wrap">
                            <span class="reg-span">????????? ????????????</span>
                            <span class="explain-span files-msg">[ ?????? ???????????? 5????????? ?????? ???????????????. ]</span>
                        </div>
                        <label class="file-box">
                            <div class="file-box-left">
                                ?????? ??????
                            </div>
                            <div class="file-box-right upload-msg">
                                ????????? ???????????? ????????????.
                            </div>
                            <input type="file" name="files" id="ajax-file-multi" class="file-input imgs-input" multiple>
                        </label>
                        <div class="uploaded-list"> </div>

                    </div>


                    <div id="reg-btn">
                        <button id="post-reg-btn" class="white-box">??????</button>
                    </div>
                </form> <!-- // end write-form -->
            </div> <!-- // end inner-section -->
        </section> <!-- // end section -->

    </div> <!-- end wrap -->



    <script>
        // start jQuery
        $(document).ready(function () {

            const account = "${account}";
            console.log(account);

            // ?????????, ?????? ????????? ????????????
            showdomainList();
            savePlatformClickEvent();
            showGenreList();
            saveGenreClickEvent();



            // ????????? ?????? ?????????
            const $form = $('#write-form');
            // console.log($form);
            $form.on({
                keydown: function (e) {
                    return checkKeydown(e);
                },
                keyup: function (e) {
                    checkKeyup(e);
                }
            });


            // ????????? ?????? ??? ?????? ?????????
            const $regBtn = $('#post-reg-btn');
            // jQueryTagTest($regBtn, "?????? ?????? ?????????");
            $regBtn.click(e => {
                e.preventDefault();
                if (!validateFormValue()) {
                    return;
                }
                beforeSubmit();
                $('#write-form').submit();
            })



            // platform jquery ========================================================


            // ????????? ???????????????
            $('.platformClick').hide();
            $('.platformInputShowEvent').click(function () {
                // alert("platform");

                $('.platformClick').show();
            });
            // ????????? ????????????




            // ?????? ???????????????
            $('.textClick').hide();
            $('.GenreInputShowEvent').click(function () {
                // alert("hihihi");

                $('.textClick').show();
            });

            // 1. ????????? value??? ????????????
            $('#platformselect').change(function () {

                // alert($(this).val());
                // console.log("????????? ?????????id : " + $(this).val());
                $("#platformselect").val($(this).val()).prop("selected", true);
                // $('#platformselect option:eq($(this).val())').prop('selected', true);
                // $('#platformselect').val($(this).val()).prop("selected", true);
                // console.log("selected : " + $("#platformselect option:selected").val());
                // alert($("#platformselect option:selected").val());

            });

            $('#genreSelect').change(function () {

                // alert($(this).val());
                // console.log("genreSelect: " + $(this).val());
                // $('#genreSelect').val($(this).val()).attr("selected", "selected");
                $('#genreSelect').val($(this).val()).prop("selected", true);
                // console.log("genreSelect selecded : " + $("#genreSelect option:selected").val());
                // alert($( "#genreSelect option:selected" ).val());

            });

            //========================????????? ??????====================//

            // ????????? ?????? ????????? ?????????
            $('.thumb-input').change(uploadAndRendeThumbnail);
            // ?????? ????????? ?????? ????????? ?????????
            $('.imgs-input').change(uploadAndRendeFiles);
            // ?????? ????????? ?????? ?????????
            $('.uploaded-list').click(delUploadImg);

            //==================================================//




        });
        // end jQuery

        // ????????? ?????? ??????
        const account = '${account}';
        const gAccount = '${account}';

        // console.log(account);
        // console.log(gAccount);

        const url = "/platform/c1/" + account;
        const genreURL = "/genre/c1/" + gAccount;
    </script>

</body>

</html>