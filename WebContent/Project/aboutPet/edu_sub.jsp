<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="header.jsp"%>
<%@include file="sidebar.jsp"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>aboutPet</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="stylesheet" href="../css/style.css" />
<script type="text/javascript"  src="../scriptAll/jquery-3.3.1.min.js" ></script>
<script type="text/javascript"  src="../scriptAll/jquery-ui.min.js"></script>
<script type="text/javascript"  src="../scriptAll/jquery.ui.datepicker-ko.js" ></script>
<script type="text/javascript"  src="../scriptAll/jquery.blockUI.js" charset="utf-8"></script>
<script type="text/javascript"  src="../scriptAll/jquery.inputmask.bundle.min.js" charset="utf-8"></script>
<script type="text/javascript"  src="../scriptAll/jquery.number.min.js" charset="utf-8"></script>
<script type="text/javascript"  src="../scriptAll/jquery.form.min.js" ></script>
<script type="text/javascript"  src="../scriptAll/jquery.countdown.js" ></script>
<script type="text/javascript"  src="../scriptAll/jquery.cookie.js" ></script>
<script type="text/javascript"  src="../scriptAll/swiper.min.js"></script>
<script type="text/javascript"  src="../scriptAll/clipboard.min.js"></script>
<script type="text/javascript"  src="../scriptAll/common.js" ></script>
<script type="text/javascript"  src="../scriptAll/popup.js" ></script>
<script type="text/javascript" 	src="../scriptAll/ui.js"></script>
<script type="text/javascript" 	src="../scriptAll/deviceChk.js"></script>	

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c334796703760a76acd7724ca50251cd&libraries=services"></script>
<script type="text/javascript" 	src="https://vknfvtjnsgec6381690.cdn.ntruss.com/_script/kakao-map.js"></script>
<script type="text/javascript" 	src="/_script/app-interface.js"></script>

<script type="text/javascript" 	src="../scriptAll/adbrix.js"></script>
<script type="text/javascript" 	src="../scriptAll/ui.mo.js"></script>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dbtckaqj51&submodules=geocoder"></script>
<script type="text/javascript">
//	const viewJsonData = JSON.parse(decodeURIComponent('%7B%22vod_group_list_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fplaylist%5C%2Flist%3Fchannel_id%3D%22%2C%22vod_group_move_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fplaylist%5C%2Fmove_vod%5C%2F%22%2C%22vod_group_add_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fplaylist%5C%2Fadd_item%5C%2F%22%2C%22vod_upload_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fvod%5C%2Fupload%5C%2F%22%2C%22vod_chnl_list_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fchannel%5C%2Flist%22%2C%22fo_mois_post_confmKey%22%3A%22U01TX0FVVEgyMDIxMDMzMDEwMzEzMDExMDk4MTk%3D%22%2C%22vod_api_chnl_id_log%22%3A%22aboutpet_log%22%2C%22vod_info_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fvod%5C%2Fvideo%5C%2Finfo%5C%2F%22%2C%22vod_group_chnl_ord_api_url%22%3Anull%2C%22vod_list_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fvod%5C%2Fvideo%5C%2F%22%2C%22vod_group_default%22%3A%22unclassified%22%2C%22vod_api_chnl_id_tv%22%3A%22aboutpet_tv%22%7D'));
</script>

<script type="text/javascript">
	$(document).ready(function(){
		/* ??????????????? ???????????? ???????????? ??? ?????? / javascript Ready Function??? ?????? */
		/*$(document).bind("contextmenu", function(e) {
		    return false;
		});*/
		
		document.addEventListener("contextmenu", e => { 
		    e.target.matches("img") && e.preventDefault()
		    e.target.matches("video") && e.preventDefault()
			e.target.className=="thumb-img" && e.preventDefault()
		})
	});

	// mw/pc ?????? ???????????? 30??? 
	var checkActionTimeOut;
	if('0' != '0' && 'PC' != 'APP'){
	    resetLoginTimeOut();
	    $(document).on('click keypress' , 'body' , function(){
	        resetLoginTimeOut();
	    });
	}
	function resetLoginTimeOut() {
		if('0' != '0' && 'PC' != 'APP'){
		    window.clearTimeout(checkActionTimeOut);
		    checkActionTimeOut = setTimeout(function() {
		        location.href="/logout/";
		    }, 30 * 60 * 1000);
		}		   
	}

	
	// ?????? -> ??? ?????? ?????? ?????????
	// ????????? ???????????? ?????? ???????????? ??????
	function updateInfoRcyYn(checkYn) {
		if("" != null && "" != "") {
			var toastText = (checkYn == "Y") ? "??????" : "??????";
					
			var options = {
					url : "/updateInfoRcvYn"
					, data : { mbrNo : "0", infoRcvYn : checkYn }
					, done : function(result) {
						if(result == "S") {
							if(checkYn != "Y") {
								ui.toast("??? ?????? ?????????" +" "+toastText +"????????????");	
							}	
						}
					}
			}
			ajax.call(options);
		}
	}

	// APP??? ????????? ?????? Callback function
	function fnGoIndexOrderPayment(data){
		var obj = JSON.parse(data);
		createFormSubmit("indexOrderPaymentForm","/order/indexOrderPayment",obj);
	}
</script>
<style type="text/css">
	/* ????????? ???????????? ???????????? ??? ?????? / css ??? ?????? */
	img, video {
		/* ????????? ?????? ????????? ????????? ?????? ???????????? ??????????????? ?????? */
		-webkit-touch-callout:none;
		/* ???????????? ???????????? ????????? ??? ?????? ?????? ????????? ?????? */
		/*-webkit-user-select:none;*/
		/* ????????? ??????????????? ????????? ?????? ????????? ????????? ?????? */
		/*-webkit-tap-highlight-color:transparent;*/
	}
</style>

<script>
// ???????????? ?????? ??????( ????????? < ????????? ?????? )
var storageHist = {
	histCnstn : "StorageHistory",		// storage ?????? ??????
	isApp : ("PC" == "APP")? true : false,
	cnvrtFullUrl : function(url) { 
		var fullUrl = url;
		if(url.indexOf('aboutpet.co.kr') < 0 && url.indexOf('localhost')  < 0 ){
			fullUrl = "https://aboutpet.co.kr"+((url.indexOf("/") != 0)?"/":"")+url;
		}			
		return fullUrl;
	},
	sendApp : function(func, url) {		// ??? ?????? ??????
		try {
			// ????????? ??????
			toNativeData.func = func;
			if(url != null && url != undefined && url != ""){
				toNativeData.url = storageHist.cnvrtFullUrl(url);
			}else{
				toNativeData.url = null;
			}
			// ??????
			toNative(toNativeData);
		} catch(e) {
			
		}
	},
	getHist : function() { 	// sessionStorage??? ????????? history ?????? ??????
		var hist = sessionStorage.getItem(storageHist.StorageHistory);
		return (hist == null)?new Array():JSON.parse(hist);
	},
	setHist : function() {	//sessionStorage??? history ??????
		/* var sessionStorageCnt = 30; */
		var thisHistory = {
				url : window.location.href,
				histLength : window.history.length
			}
		var sessionHistory = storageHist.getHist();
		if(sessionHistory == null || sessionHistory.length == 0){				// ?????? ??????
			var histArray = new Array();
			histArray.push(thisHistory);
			if(storageHist.isApp) storageHist.sendApp("onAddHistory", thisHistory.url);
			sessionStorage.setItem(storageHist.StorageHistory, JSON.stringify(histArray));
		}else{ 									// ??????
			if(sessionHistory[sessionHistory.length-1].histLength >= thisHistory.histLength){	// ???????????? ???????????? ???????????? ???????????? ??????(??????????????? ?????? ??????????????? ???????????? ??????)
				var theUrlIdx;
				sessionHistory.forEach(function(item, index, array) {
					if(item.url == thisHistory.url){
						theUrlIdx = index;
					}
				});
				if(theUrlIdx != null && theUrlIdx != undefined){
					var removeCnt = sessionHistory.length - theUrlIdx;
					sessionHistory.splice(theUrlIdx, removeCnt);
					sessionStorage.setItem(storageHist.StorageHistory, JSON.stringify(sessionHistory));
				}
			}
			
			if(sessionHistory[sessionHistory.length-1].url != thisHistory.url){
				sessionHistory.push(thisHistory);
				if(storageHist.isApp) storageHist.sendApp("onAddHistory", thisHistory.url);
				sessionStorage.setItem(storageHist.StorageHistory, JSON.stringify(sessionHistory));
			}
		}
	},
	replaceHist : function(url) {		// sessionStorage??? hisory ?????? replace?????? remove
		var sessionHistory = storageHist.getHist();
		sessionHistory.pop();	// remove
		if(url){				// url ??????
			var thisHistory = {
				url : storageHist.cnvrtFullUrl(url),
				histLength : window.history.length
			}
			sessionHistory.push(thisHistory);
		}
		if(storageHist.isApp) storageHist.sendApp("onReplaceHistory", url);
		sessionStorage.setItem(storageHist.StorageHistory, JSON.stringify(sessionHistory));
		return (sessionHistory.length == 0)?"/":sessionHistory[sessionHistory.length-1].url;
	},
	goBack : function(url){ 		// ??????????????? / ????????? ??????
// 		if(storageHist.isApp){
// 			storageHist.sendApp("onHistoryBack", url);
// 		}else 
		if(url){	// url??? ??????(?????? url ?????? ??????)
			var fullUrl = storageHist.cnvrtFullUrl(url);
			storageHist.clearUp(fullUrl);
			location.href = fullUrl;
		}else{		// ???????????????
			var lastUrl = storageHist.replaceHist();
			location.href = lastUrl;
		}
	},
	getOut : function(url, firstUrl) {		// ?????????????????? ??????(url??? ???????????? ?????? ?????? ???????????? ??????, firstUrl??? true?????? url??? ????????? ?????? ?????? url??? ??????)
		var lastUrl = storageHist.clearUp(url, true, firstUrl);
		location.href = lastUrl;
	},
	clearUp : function(url, part, firstUrl) {					// ?????? url?????? ???????????? ?????? ???????????? (part??? true?????? ?????? url?????? ?????? ??????)
		var sessionHistory = storageHist.getHist();
		var theUrlIdx;
		var isFinding = true;
		if(part){		// url??? ???????????? ????????? ??????
			sessionHistory.forEach(function(item, index, array) {
				if(firstUrl){
					if(isFinding){
						if(item.url.indexOf(url) != -1 ){
							theUrlIdx = index;
							isFinding = false;
						}
					}
				}else{
					if(item.url.indexOf(url) == -1 ){
						theUrlIdx = index+1;
					}
				}
			});
		}else{			// ?????? url?????? ??????
			sessionHistory.forEach(function(item, index, array) {
				if(item.url == url){
					theUrlIdx = index+1;
				}
			});
		}
		
		if(theUrlIdx != null && theUrlIdx != undefined){
			var removeCnt = sessionHistory.length - theUrlIdx;
			sessionHistory.splice(theUrlIdx, removeCnt);
			sessionStorage.setItem(storageHist.StorageHistory, JSON.stringify(sessionHistory));
		}
		return (sessionHistory.length == 0)?"/":sessionHistory[sessionHistory.length-1].url;
	},
	clearHist : function() {			// history ?????? ??????
		sessionStorage.removeItem(storageHist.StorageHistory);
		if(storageHist.isApp) storageHist.sendApp("onClearHistory");
	}
}

// sessionStorage ?????? ?????? / ????????? clear
var thisUrl = window.location.href;
if(thisUrl.indexOf('?returnUrl=') == -1 && thisUrl.indexOf('&returnUrl=') == -1 && (thisUrl.indexOf('/tv/home')>0 ||thisUrl.indexOf('/log/home')>0 || thisUrl.indexOf('/shop/home')>0 || thisUrl.indexOf('/mypage/indexMyPage')>0)){  // history clear
	storageHist.clearHist();
	storageHist.setHist();
}else{	// history ??????
	storageHist.setHist();
}
console.log("storageHist",storageHist.getHist());
</script><!-- Google Tag Manager -->
<!-- For Analysis Container -->
<script>
(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-NKC9BFM');
</script>

<!-- For Campaign Container -->
<script>
(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-M82SBBJ');
</script>
<!-- End Google Tag Manager -->
<!-- <script src="https://devsgr.aboutpet.co.kr/player/thumb_api/v1.js"></script> -->
	<script>
		// ????????? ????????? ????????? ??????
		$("#sgrplayer_r1cpmgj14rc").on("contextmenu", function(event) { event.preventDefault();});
		var autoFlag = false;
		var shareThumImgBase64 = "";
		var shareThumImg;
		var execEvent = false;
		var histCnt = Number("0");
		var histLoginCnt = Number("0");
		histCnt = histCnt + histLoginCnt; 
		
		$(document).ready(function(){
			
			
			$("head").append("<style>body, html, .wrap{height:100%;}</style>");
			
			
			
			/* ??? ?????? ???,?????? ?????? ??????. ?????????????????? black */
			/* ???????????????????????? */
						
			//???????????? ??????
			saveEduHistory(0);
			//??????????????????
			fncAutoFlag();
			//????????? ??????
			regHitCnt();
			 //?????? ?????????-??????
			userActionLog("E2021042301050", "watch");
			
			$(".swiper-pagination span").last().css("display","none");
			$(".swiper-pagination").show();
			
			$(document).click(function (e) {
				if(!$(e.target).closest(".prd-layer .cont").length ) {
					$('.prd-layer').slideUp('300');
					e.stopPropagation();
				}
			});
			
			/* 04.08 : ?????? */
			$(".page.tv .prd-layer .top .inner").click(function(e){
				e.stopPropagation();
			});
			/* 04.08 : ?????? */
			
			if("false" == "true"){
				//???????????? ???????????? ?????? ??? ?????????????????? ???????????? ???????????? ????????????
				var queryString = "vdId=E2021042301050";
				var newQueryString = queryString.substring(0, queryString.indexOf("&goodsVal"));
				
				if("" == "goods"){
					var replaceUrl = "/tv/school/indexTvDetail?"+newQueryString;
					history.replaceState("", "", replaceUrl);
					storageHist.replaceHist(replaceUrl);
					
					getRelatedGoodsWithTv($("#videoTing"), 'E2021042301050', "N");
				}else if("" == "cart"){
					var replaceUrl = "/tv/school/indexTvDetail?"+newQueryString;
					history.replaceState("", "", replaceUrl);
					storageHist.replaceHist(replaceUrl);
					
					getRelatedGoodsWithTv($("#videoTing"), 'E2021042301050', "Y");
				}
			}
		});
		
		
		var myLastStep = 0;//??????????????? ???????????? ????????? ????????? ??????
		var myLastStepTime = 0;//??????????????? ???????????? ????????? ????????? ??????
		var outVdIdArr = new Array();//???????????????ID ARR		
		//var temp = document.getElementById("div_sgrplayer_js6mbc0rwd9").video_src;	//???
		var nowStepIdx = 0;
		/* ?????????????????? */
		/* ??? ????????? ????????? ?????? */
		/* ????????? ????????? ??????????????? ???????????? ?????? ?????? */		
		/* ?????? */
									
					nowStepIdx = 0;	
					
					outVdIdArr.push("z3AC115420880"); 
									
					outVdIdArr.push("Ahmi108413207");
									
					outVdIdArr.push("Slyj24456254");
									
					outVdIdArr.push("SXbB109638943"); 
									
					// outVdIdArr.push(temp);
				
				
		
		// ???????????? ?????? ??? ?????? ??????
		$(document).mouseup(function (e){
			var LayerPopup = $(".popup-layer");
			var prdLayerPopup = $(".prd-layer");
			  
			if(prdLayerPopup.has(e.target).length === 0){ // ???????????? ????????? ?????????
				if(LayerPopup.has(e.target).length === 0){
					$(".btnPopClose").click();
				}  
			}
		});
		
		</script></head>

<body class="body tv schoolDetail isPc gnb_ac" style="">
<!-- Google Tag Manager (noscript) -->
<!-- For Analysis Container -->
<noscript>
<iframe src="//www.googletagmanager.com/ns.html?id=GTM-NKC9BFM"
height="0" width="0" style="display:none;visibility:hidden"></iframe>
</noscript>

<!-- For Campaign Container -->
<noscript>
<iframe src="//www.googletagmanager.com/ns.html?id=GTM-M82SBBJ"
height="0" width="0" style="display:none;visibility:hidden"></iframe>
</noscript>
<!-- End Google Tag Manager (noscript) -->
<!-- ?????? ????????? -->
	<div class="wrap" id="wrap">
		<input type="hidden" id="viewJsonData" value="%7B%22vod_group_list_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fplaylist%5C%2Flist%3Fchannel_id%3D%22%2C%22vod_group_move_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fplaylist%5C%2Fmove_vod%5C%2F%22%2C%22vod_group_add_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fplaylist%5C%2Fadd_item%5C%2F%22%2C%22vod_upload_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fvod%5C%2Fupload%5C%2F%22%2C%22vod_chnl_list_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fchannel%5C%2Flist%22%2C%22fo_mois_post_confmKey%22%3A%22U01TX0FVVEgyMDIxMDMzMDEwMzEzMDExMDk4MTk%3D%22%2C%22vod_api_chnl_id_log%22%3A%22aboutpet_log%22%2C%22vod_info_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fvod%5C%2Fvideo%5C%2Finfo%5C%2F%22%2C%22vod_group_chnl_ord_api_url%22%3Anull%2C%22vod_list_api_url%22%3A%22https%3A%5C%2F%5C%2Fsgr.aboutpet.co.kr%5C%2Fv1%5C%2Fvod%5C%2Fvideo%5C%2F%22%2C%22vod_group_default%22%3A%22unclassified%22%2C%22vod_api_chnl_id_tv%22%3A%22aboutpet_tv%22%7D">
		
		<!-- s : header ?????? -->
					<script type="text/javascript">
	//???????????????????????? console.[log, debug] control	
	logger("prd");
	
	$(document).ready(function(){
		
		if("DEVICE_TYPE" != "DEVICE_TYPE"){
			if("PC" == "MO"){
				$("meta[name=viewport]").attr("content","width=device-width, initial-scale=1, maximum-scale=4, user-scalable=yes");
			}else if("PC" == "PC"){
 				$("meta[name=viewport]").attr("content","width=device-width, initial-scale=0, maximum-scale=6, user-scalable=yes");
 			}
		}

		//IE ?????? ??? edge??? ??????
		if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
			
			document.body.innerHTML = '';
		
			function edgeAlert(){
				alert("??????????????? Internet Explorer??? ???????????? ????????????. \n??????, ?????? ??????????????? ????????? ??????????????????.")
				location.href = "microsoft-edge:" + location.href;
			}
			function closeIE(){
				open("","_self").close();
			}
			setTimeout(edgeAlert);
	        setTimeout(closeIE,200);
		}
		
		if(document.cookie.indexOf("DEVICE_GB") == -1){
			ipadCheck();
		}
		chcekLoginTagInfo(); 
		checkURL();
		
		setCartCnt();
		
		
		// ????????? ??????
		getSearchInputAutoComplete();
		
		$("li[id^=liTag_]").one('click', function(){
			$("li[id^=liTag_]").removeClass("active");
			$(this).addClass("active");
	    });
		
		$(document).on("click" , "#alertBtn" , function(){
			getAlertList();
		});
	});
	
	function getAlertList(){
		var options = {
				url : "/alertList"
				, dataType : "html"
				, done : function(html){
					$("#alertBtn").removeClass("on");
					if("PC" == "PC"){
						$("#alertDiv").html(html);	
					}else{
						location.href="/alertList"	
					}
				}
		}
		ajax.call(options);
	}
	
	// ipad check logic
	function ipadCheck(){
		const iPad = (navigator.userAgent.match(/(iPad)/) /* iOS pre 13 */ ||  (navigator.platform === 'MacIntel' && navigator.maxTouchPoints > 1) /* iPad OS 13 */);
		if(iPad){
			setCookie("DEVICE_GB", "MO" , 24 );
			window.location.reload();
		}
	}
	
	//?????? ???????????? ?????? ?????? ??????
	function chcekLoginTagInfo(){
		if("" != "Y" && "0" > 0 && "" == ""){
			location.href = "/join/indexTag?isPBHR=Y&returnUrl="+location.pathname+location.search;
		}
	}
	
	function setCookie( name, value, expirehours ) {
		var todayDate = new Date();
		todayDate.setHours( todayDate.getHours() + expirehours );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	
	// ???????????? ????????????
	function todaycloseWin(pNo) {
		setCookie("#popDispClsfNo"+pNo, "done" , 24 );
	}
	
	$(function() {
		$('.category_wrap').on('show', function(e, param1) {
			if (param1 == "cate") {
				$('.right_btn_wrap').hide();
				
				var options = {
					url : "/brand/listStyleBrand",
					done : function(data) {
						var html = "";
						for (var i=0; i<data.brandStyleList.length; i++) {
							var brand = data.brandStyleList[i];
							html += '<li><a href="/brand/indexBrandDetail?bndNo=' + brand.bndNo + '">' + brand.bndNm + '</a></li>';
						}
						$('.dep_box.style ul').html(html);
					}
				};
				ajax.call(options);
			}
		});
		
		$('.category_wrap').on('hide', function(e, param1) {
			if (param1 == "cate")
				$('.right_btn_wrap').show();
		});
	});	
	
	// ??????
	function goSearch(dispClsfNo){
		
		var searchWord = $("#srchWord").val();
		var srchShopWord = $("#srchShopWord").val();
		if( srchShopWord != "" &&  srchShopWord != undefined){
			searchWord = srchShopWord;
		}
		var srchShopDispClsfNo = convertDispClsfNo((dispClsfNo == "" || dispClsfNo == undefined) ? "300000173" : dispClsfNo);
		// google Analytics ?????? ??????
		search_data.search_term = searchWord;
		sendGtag('search');
		// ????????? ?????? ????????? ?????? url ??????
		var lastUrl = window.location.href;
		if(lastUrl.indexOf("commonSearch") == -1){
			$.cookie("searchLastUrl", lastUrl, {path:'/'});
			$.cookie("searchLastFocus", "20", {path:'/'});
			location.href = "/commonSearch?focus=20"+((searchWord.trim() == "")? "":"&srchWord="+encodeURIComponent(searchWord.trim()))+"&cateCdL="+srchShopDispClsfNo;
		}else{
			var searchLastFocus = $.cookie("searchLastFocus");
			location.href = "/commonSearch?"+((searchLastFocus == "" || searchLastFocus == undefined )?"":"focus="+searchLastFocus)+((searchWord.trim() == "")? "":"&srchWord="+encodeURIComponent(searchWord.trim()))+"&cateCdL="+srchShopDispClsfNo;
		}
	}
	
	// ?????? ?????????	
	function checkURL() {
		var pathname = location.pathname;
		
		//???????????????(bizNo??? ?????? ??????)??? ???????????? ?????? ?????? ???????????? ???????????? alert
		if(pathname.indexOf("/log/") < 0 && "" != "" && "" > 0 && pathname.indexOf("/my/pet/") < 0 && pathname.indexOf("/commonSearch") < 0){
			if(confirm("???????????? ?????????. ???????????? ???????????????????")){
				location.href="/logout";
			}else{
				history.back(-1);
			}
		}
		
		var menu = $('.top_area .nav').children("li");
		
		for (var i=0; i<menu.length; i++) {
			var url = $(menu[i]).find("a").attr("href");
			if (url == location.pathname)
				$(menu[i]).addClass("active");
		}
	}
	
	// ??????????????? ?????? - ??????????????????
	function insertWish(obj, goodsId){
		if( $(".popToast").is(":visible") ) return;

		var options = {
			url : "/goods/insertWish",
			data : {goodsId : goodsId},
			done : function(data){
				if(data.actGubun =='login'){
					//???????????? ??? ?????? ?????? ??????.
					document.location.href = '/indexLogin?returnUrl='+encodeUriComponent(document.location.href);
				}else if(data.actGubun =='add'){
					$(obj).addClass("on");
					let msg = '<div class="link"><p class="tt">??????????????? ??????????????????</p><a href="/mypage/shop/myWishList" class="lk" data-content="" data-url="/mypage/shop/myWishList">????????????</a></div>';
					ui.toast(msg,{
						bot:77
					});
					//if (confirm("?????????????????? ???????????????.\n?????????????????????????")) location.href = "/mypage/interest/indexWishList";
				}else if(data.actGubun =='remove'){
					$(obj).removeClass("on");
					ui.toast("?????????????????? ??????????????????", {
						bot:77
					})
					//alert("????????????????????? ?????????????????????.");
				}else{
					let act = $(obj).hasClass("on") ? "??????" : "??????";
					ui.toast("??? "+act+" ????????? ?????????????????????", {
						bot:77
					});
					//alert('??????????????? ?????? ?????? ????????? ?????????????????????.');
				}
			}
		};
		ajax.call(options);
	}
	
	function insertWishS(obj, goodsId, query) {
		var options = {
			url : "/goods/insertWish",
			data : {goodsId : goodsId, search : "Y", returnUrl : document.URL+"?searchQuery="+query },
			done : function(data) {
				$(obj).addClass("click");
			}
		};
		ajax.call(options);
	}

	function goEvent(){
		var id = $(".tmenu .list .active").prop("id");
		var url = "";
		var eventGb2Cd = "10";
		//??????
		if(id =="liTag_10"){
			eventGb2Cd = "40";
		}
		//???tv
		else if(id =="liTag_20"){
			eventGb2Cd = "20";
		}
		//?????????
		else if(id =="liTag_30"){
			eventGb2Cd = "30";
		}

		window.location.href = "/event/main";
	}
	
	$(function () {
		// ?????? ??????
		$(".searchMenuContent").hide();
		$(".searchMenuContent:first").show();

		$("ul.searchMenu li").click(function () {
			$("ul.searchMenu li").removeClass("active");
			$(this).addClass("active");
			$(".searchMenuContent").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});
		
		//?????? : ????????????
		$(".categorySub").hide();
		$(".categorySub:first").show();

		$("ul.searchCate li").click(function () {
			$("ul.searchCate li").removeClass("active");
			$(this).addClass("active");
			$(".categorySub").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});

		//?????? : ?????????
		$(".brandSub").hide();
		$(".brandSub:first").show();

		$("ul.searchBrand li").click(function () {
			$("ul.searchBrand li").removeClass("active");
			$(this).addClass("active");
			$(".brandSub").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});

		//????????? : ??????/???????????????
		$(".searchKindSub").hide();
		$(".searchKindSub:first").show();

		$("ul.searchKind li").click(function () {
			$("ul.searchKind li").removeClass("active");
			$(this).addClass("active");
			$(".searchKindSub").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});
		
		// ?????? ????????? ?????? ???
		$(".btnSch").on("click", function(){
			goSearch();
		});
		// ?????? ?????????
		var thisUrl = window.location.href;
		if(thisUrl.indexOf("commonSearch") == -1){
			$("#srchWord, #srchShopWord").on("click", function(){
				goSearch();
			});
		}else{
			$(document).on("keypress","#srchWord, #srchShopWord",function(e){
				if ( event.keyCode == 13 ) {
					goSearch();
				}
			});
		}
	
		// ???????????? ?????? ????????? ??????
		$(window).scroll(function(){
			if(document.activeElement.name == 'srchWord'){
				$("#srchWord").blur();
			}
		});
		
		// ????????? AI ????????? ??????
		let mbrNo, section, contentId, baseUrl, targetUrl, litd, lttd, agent = "";
		$("a, button").on("click", function(){
			// ????????????
			mbrNo = "D13C243DFB3ABA7313050925F51D261A";
			if("" != "0"){
				mbrNo = "0";
			}
			
			// ????????????
			section = "20";
			if("10" == section){
				section = "shop";
			} else if("20" == section){
				section = "tv";
			} else if("30" == section){
				section = "log";
			} else {
				section = "member";
			}
			
			// ?????????/?????? ??????/????????????/????????????(data-content)
			contentId = $(this).data("content");
			
			// ?????? URL
			if("" != $(this)[0].baseURI){
				baseUrl = $(this)[0].baseURI;
			}
			
			// ?????? URL
			if("" != $(this).data("url") && "undefined" != typeof  $(this).data("url")){
				targetUrl = $(this).data("url");
			} else if("" != $(this)[0].href && "#" != $(this)[0].href){
				targetUrl = $(this)[0].href;
			} else if("" != $(this)[0].onclick){
				targetUrl = $(this)[0].onclick;
			}
			
			// Device, Device OS, ??????, ?????? ??????
			if("PC" == "APP"){
				agent = "APP_" + jscd.typeOs;
				
				// ???????????? ???????????? ??????
				var headerPstInfoAgrYn = "N";
				
				
				// APP ibricks Interface
				var data = {
					      "mbr_no" : mbrNo
						, "section" : section
						, "content_id" : contentId
						, "action" : "etc"
						, "url" : baseUrl
						, "target_url" : targetUrl
						, "agent" : agent
						, "prclAddr" : ""
						, "roadAddr" : ""
						, "postNoNew" : ""
						, "timestamp" : ""
						, "pstInfoAgrYn" : headerPstInfoAgrYn
				};
				toNativeData.func = "onIbrixClick";
				toNativeData.parameters = JSON.stringify(data);
				toNative(toNativeData);
			} else {
				agent = "WEB_" + jscd.typeOs; 
		
				$.ajax({
					url : "/common/sendSearchEngineEvent"
					, data : {
						  "mbr_no" : mbrNo
						, "section" : section
						, "content_id" : contentId
						, "action" : "etc"
						, "url" : baseUrl
						, "targetUrl" : targetUrl
						, "agent" : agent
						, "prclAddr" : ""
						, "roadAddr" : ""
						, "postNoNew" : ""
						, "timestamp" : ""
					}
				});
			}
			// Device, Device OS, ??????, ?????? ??????
		});
	});
	
	// APP??? ibricks Callback function
	function interfaceIbricksCallback(responseData){
		var response = $.parseJSON(responseData);
		$.ajax({
			url : "/common/sendSearchEngineEvent"
			, data :{
			      "mbr_no" : response.mbrNo
					, "section" : response.section
					, "content_id" : response.contentId
					, "action" : response.action
					, "url" : response.baseUrl
					, "target_url" : response.targetUrl
					, "agent" : response.agent
					, "litd" : response.litd
					, "lttd" : response.lttd
					, "prclAddr" : response.prclAddr
					, "roadAddr" : response.roadAddr
					, "postNoNew" : response.postNoNew
					, "timestamp" : ""
			}
		});
	}
	
	// APP??? Device, Device OS, ??????, ?????? ??????
	function onCurrentLocCallBackIbricks(resultJson){
		var result = $.parseJSON(resultJson);
		agent = "APP_" + jscd.typeOs;
		if( result.authYn !== undefined && result.authYn == 'Y'){
			appLocAuthYn = "Y";
			lttd = result.latitude;
			litd = result.longitude;
			
			$.ajax({
				url : "/common/sendSearchEngineEvent"
				, data : {
					  "mbr_no" : mbrNo
					, "section" : section
					, "content_id" : contentId
					, "action" : "etc"
					, "url" : baseUrl
					, "target_url" : targetUrl
					, "litd" : litd
					, "lttd" : lttd
					, "agent" : agent
					, "timestamp" : ""
				}
			});
		}
	}
	// APP??? Device, Device OS, ??????, ?????? ??????
	
	// ???????????? ??????
	function goPetShopMain() {
		var form = document.createElement("form");
		document.body.appendChild(form);
		var url = "/shop/home/";
		form.setAttribute("method", "POST");
		form.setAttribute("action", url);

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "lnbDispClsfNo");
		hiddenField.setAttribute("value", '');
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		form.submit();
	}
	
	// ???????????? ?????????
	function sendDispClsfNo(dispClsfNo){
		var lnbDispClsfNo = dispClsfNo
		var cateCdL = dispClsfNo
		cateCdL = convertDispClsfNo(dispClsfNo);
		
		var form = document.createElement("form");
		document.body.appendChild(form);
		var url = "/tv/school/indexTvDetail";
		if("/tv/school/indexTvDetail" == "/event/indexSpecialExhibitionZone"){
			url = "/shop/home";
		}
		
		var hiddenField = document.createElement('input');
		hiddenField.setAttribute('type', 'hidden');
		hiddenField.setAttribute('name', 'lnbDispClsfNo');
		hiddenField.setAttribute('value', lnbDispClsfNo);
		form.appendChild(hiddenField);
		
		if("/tv/school/indexTvDetail" == "/shop/indexCategory"||
			"/tv/school/indexTvDetail" == "/event/indexExhibitionZone") {
			form.setAttribute("method", "GET");
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "cateCdL");
			hiddenField.setAttribute("value", cateCdL);	// 12564
			form.appendChild(hiddenField);
			document.body.appendChild(form);
		}else if("/tv/school/indexTvDetail" == "/shop/indexNewCategory" ||
				 "/tv/school/indexTvDetail" == "/shop/indexBestGoodsList") {
			var dispCornType = $("input[id^=dispCornType_]").val();
			form.setAttribute("method", "GET");
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "dispCornType");
			hiddenField.setAttribute("value", dispCornType);
			form.appendChild(hiddenField);
			document.body.appendChild(form);
		}else if("/tv/school/indexTvDetail" == "/pet/event/petshopEventList" ||
			"/tv/school/indexTvDetail" == "/shop/indexLive" ){				
			form.setAttribute("method", "GET");
		}else if("/tv/school/indexTvDetail" == "/event/shop/main"){
			form.setAttribute("method", "GET");
			form.removeChild(hiddenField);

			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "dispClsfNo");
			hiddenField.setAttribute("value", lnbDispClsfNo);
			form.appendChild(hiddenField);
		}
		else {
			form.setAttribute("method", "POST");
		}
		form.setAttribute("action", url);
		document.body.appendChild(form);
		form.submit();
	}
	
	function convertDispClsfNo(dispClsfNo) {
		var cateCdL = '12564';
		
		if('300000174' == dispClsfNo ) {	// ?????????
			cateCdL = '12565'
		} else if('300000175' == dispClsfNo ) {	// ?????????
			cateCdL = '14111'
		} else if('300000176' == dispClsfNo ) {	// ?????????
			cateCdL = '14196'
		}
		
		return cateCdL;	
	}
	
	function getSearchInputAutoComplete() { 
		$.post( "/shop/getSearchInputAutoComplete",	function( data ) {
			var srchText = "???????????? ??????????????????.";
			if(data.searchBox != null && data.searchBox.bnrText != null && data.searchBox.bnrText != ''){
				srchText = data.searchBox.bnrText;
			}
			// ????????? ?????????
			$("#srchWordMO").text(srchText);
			// pc ?????????
			$("#srchWord").attr("placeholder", srchText);
			$("#srchShopWord").attr("placeholder", srchText);
		});
	}
	
	function clickLogin(){
		location.href = "/indexLogin?returnUrl="+location.pathname+location.search;
	}
	
	
	//???????????? ??? set, ?????? ????????? ajax ??????
	function setCartCnt(){
		$.ajax({
			url : "/order/getCartCnt"
			, dataType : "json"
			, type : "POST"
			, success : function(data){
				var $cartCntObj = $('.header .menu .cart').find('em');
				if($cartCntObj.length == 0){
					if(data.cartCnt != 0){
						var html = '<em class="n">'+data.cartCnt+'</em>';
						$('.header .menu .cart').html(html);
					}
				}else{
					if(data.cartCnt == 0){
						$cartCntObj.remove();
					}else{
						$cartCntObj.text(data.cartCnt);
					}
				}
			}
		});
	}

	function loadCornerGoodsList(dispClsfNo, dispCornNo, dispClsfCornNo, dispType, timeDeal) {
		var petNo = $("#petNo_rec").val();
		var form = document.createElement("form");
		document.body.appendChild(form);
		var url = "/shop/indexGoodsList";
		form.setAttribute("method", "GET");
		form.setAttribute("action", url);

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dispClsfNo");
		hiddenField.setAttribute("value", dispClsfNo);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dispCornNo");
		hiddenField.setAttribute("value", dispCornNo);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dispClsfCornNo");
		hiddenField.setAttribute("value", dispClsfCornNo);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dispType");
		hiddenField.setAttribute("value", dispType);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		if(timeDeal != undefined) {
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "timeDeal");
			hiddenField.setAttribute("value", timeDeal);
			form.appendChild(hiddenField);
			document.body.appendChild(form);
		}
		if(dispType == 'RCOM') {
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "petNo");
			hiddenField.setAttribute("value", petNo);
			form.appendChild(hiddenField);
			document.body.appendChild(form);
		}
		form.submit();
	}
    
  	//?????? ??????????????? ???????????? ?????? 2021.05.13
	var rankBox = function(){
		ui.popLayer.open('popLank',{
			ocb:function(){
				// console.log("popLank ??????");
			},
			ccb:function(){
				// console.log("popLank ??????");
			}
		});

		if("PC" == "PC") {
			$(".rank_pc").addClass("on");
		}else {										
			$(".rank_mo").addClass("on");
		}
	}
  	
</script>


		
		<div class="layers">
			<!-- ??????????????? ?????? ?????? -->
			<!-- ???????????? ?????? ?????? 2021.05.13 -->
			<article class="popLayer a popLank " id="popLank">
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit"></h1>
							<button type="button" class="btnPopClose">??????</button>
						</div>
					</div>
					<div class="pct">
						<main class="poptents">
							<div class="rankCont">
								<div class="rank_imgBox rank_pc">
											<img src="/_images/common/img-level-pc.png" alt="???????????? ????????? ????????? ?????? ?????????">
										</div>
									</div>
						</main>
					</div>
				</div>
			</article>
			<!-- //???????????? ?????? ?????? 2021.05.13 -->
		</div>
<!--// header pc--><!-- e : header ?????? -->
					<!-- s : gnb ?????? -->
					<script type="text/javascript">
function setCateList(dispClsfNo, upDispClsfNo) {
	var dispClsfNo2 ='';	
	if('12564' == upDispClsfNo ) {			// ?????????
		dispClsfNo2 = '300000173'
	} else if('12565' == upDispClsfNo ) {	// ?????????
		dispClsfNo2 = '300000174'
	} else if('14111' == upDispClsfNo ) {	// ?????????
		dispClsfNo2 = '300000175'
	} else if('14196' == upDispClsfNo ) {	// ?????????
		dispClsfNo2 = '300000176'
	}
	
	location.href = "/shop/indexCategory?dispClsfNo="+dispClsfNo+"&dispClsfNo2="+dispClsfNo2+"&cateCdL="+upDispClsfNo+"&cateCdM="+dispClsfNo;
}

function goIndexLoginSettings() {
	location.href = "/indexLoginSettings?returnUrl=" + window.location.pathname;
}

//????????? ??????
function seriesOpen(){
	var options = {
		url : "/tv/series/getSeriesList"
		, type : "POST"
		, dataType : "html"
		, data : { }
		, done : function(result){
			$("#gnbSrisListPopup").empty();
			$("#gnbSrisListPopup").html(result);
			ui.gnb.using("close"); //????????? ?????? ????????? ?????? ????????? gnb??????(????????????) ??????
			ui.popLayer.open('popSeriesList');
		}
	};
	ajax.call(options);
}


function goMyPetLogGnb(){
	if( checkLoginGnb() && checkRegPetGnb() ){
		location.href = "https://aboutpet.co.kr/log/indexMyPetLog/?mbrNo=0";
	}
}


function checkLoginGnb(){
	if( "false" != "true" ){
		ui.confirm('????????? ??? ???????????? ????????? ??? ?????????.<br>????????? ??????????',{ // ?????? ??? ?????????
			ycb:function(){
				location.href = "https://aboutpet.co.kr/indexLogin";
			},
			ncb:function(){
				return false;
			},
			ybt:"?????????", // ????????? "??????"
			nbt:"??????"  // ????????? "??????"
		});
	}else{
		return true;
	}
}


function checkRegPetGnb(){	
	if( "" == null || "" == ""){
		ui.confirm('????????? ?????? ??? ????????? ??? ?????????<br/>???????????? ????????????????',{ // ?????? ??? ?????????
			ycb:function(){
				// ???????????? ?????? ???????????? ??????.
				location.href = "https://aboutpet.co.kr/my/pet/petInsertView";
			},
			ncb:function(){
				//alert('??????');
				return false;
			},
			ybt:"???", // ????????? "??????"
			nbt:"?????????"  // ????????? "??????"
		});
	}else{
		return true;
	}
}

</script>
<nav class="gnb" id="gnb">
	<div class="inr">
		<div class="hdt">
			<div class="logo">aboutPet</div>
			<div class="bts"><button class="bt close">????????????</button></div>
		</div>
		<div class="cdt">
			<div class="menu">
				<ul class="list">
					<li class="tv active">
						<a class="bt" href="javascript:;">??? TV</a>
						<div class="box">
							<ul class="sm">
								<li><a class="bt" href="/tv/petTvList?dispCornNo=567">????????????</a></li>
								<li><a class="bt" href="/tv/petTvList?dispCornNo=568">????????????</a></li>
								<li><a class="bt" href="/tv/petSchool">?????????</a></li>
								<li><a class="bt" href="javascript:seriesOpen();">???????????????</a></li>
							</ul>
						</div>
					</li>
					<li class="log ">
						<a class="bt" href="javascript:;">?????????</a>
						<div class="box">
							<ul class="sm">
								<li><a class="bt" href="javascript:goMyPetLogGnb();">MY ?????????</a></li>
							</ul>
						</div>
					</li>
					<li class="shop ">
						<a class="bt" href="javascript:;">??? ???</a>
					<div class="box">
							<div class="cate slideShop">
								<div class="swiper-container">
									<ul class="swiper-wrapper slide">
									<li class="swiper-slide active"><a data-ui-tab-btn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12564" href="javascript:;" class="bt">?????????</a></li>
												<li class="swiper-slide "><a data-ui-tab-btn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12565" href="javascript:;" class="bt">?????????</a></li>
												<li class="swiper-slide "><a data-ui-tab-btn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14111" href="javascript:;" class="bt">?????????</a></li>
												<li class="swiper-slide "><a data-ui-tab-btn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14196" href="javascript:;" class="bt">?????????</a></li>
												</ul>
								</div>
							</div>
							<div class="ctset active" data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12564">
									<ul class="sm">
								<li><a class="bt"  href="javascript:setCateList('12569', '12564');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12571', '12564');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12572', '12564');">????????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12573', '12564');">?????????/??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12575', '12564');">??????/??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12576', '12564');">??????/??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12577', '12564');">??????/?????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12578', '12564');">?????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12579', '12564');">??????/??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12581', '12564');">??????/?????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('13998', '12564');">?????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('100000196', '12564');">???????????????</a></li>
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12565">
									<ul class="sm">
								<li><a class="bt"  href="javascript:setCateList('12673', '12565');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12675', '12565');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12676', '12565');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12677', '12565');">????????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12678', '12565');">?????????/??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12679', '12565');">?????????/??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12680', '12565');">??????/?????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12682', '12565');">??????/??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12683', '12565');">????????????/?????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12684', '12565');">?????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('12685', '12565');">??????/??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14005', '12565');">?????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14006', '12565');">??????/?????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('100000198', '12565');">???????????????</a></li>
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14111">
									<ul class="sm">
								<li><a class="bt"  href="javascript:setCateList('14112', '14111');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14114', '14111');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14115', '14111');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14116', '14111');">????????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14117', '14111');">????????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14118', '14111');">?????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14119', '14111');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14120', '14111');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14121', '14111');">????????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14122', '14111');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14123', '14111');">????????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14262', '14111');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('100000199', '14111');">????????????</a></li>
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14196">
									<ul class="sm">
								<li><a class="bt"  href="javascript:setCateList('14197', '14196');">?????????/??????/??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14198', '14196');">??????/????????????/?????????/??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14199', '14196');">????????????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14200', '14196');">???</a></li>
								<li><a class="bt"  href="javascript:setCateList('14201', '14196');">??????</a></li>
								<li><a class="bt"  href="javascript:setCateList('14202', '14196');">?????????</a></li>
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12569">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12571">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12572">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12573">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12575">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12576">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12577">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12578">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12579">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12581">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_13998">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_100000196">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12673">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12675">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12676">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12677">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12678">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12679">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12680">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12682">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12683">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12684">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_12685">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14005">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14006">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_100000198">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14112">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14114">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14115">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14116">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14117">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14118">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14119">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14120">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14121">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14122">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14123">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14262">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_100000199">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14197">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14198">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14199">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14200">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14201">
									<ul class="sm">
								</ul>
							</div>
							<div class="ctset " data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_14202">
									<ul class="sm">
								</ul>
							</div>
							<!-- 							<div class="ctset" data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_6"> -->
<!-- 								???????????? -->
<!-- 							</div> -->
						</div>
					</li>
					<li class="my ">
						<a class="bt" href="javascript:;">MY</a>
						<div class="box">
							<div class="cate slideShop">
								<div class="swiper-container">
									<ul class="swiper-wrapper slide">
										<li class="swiper-slide active"><a data-ui-tab-btn="tab_my_cate" data-ui-tab-val="tab_my_cate_1" href="javascript:;" class="bt">??? ??????</a></li>
										<li class="swiper-slide"><a data-ui-tab-btn="tab_my_cate" data-ui-tab-val="tab_my_cate_2" href="javascript:;" class="bt">??? ????????????</a></li>
										<li class="swiper-slide"><a data-ui-tab-btn="tab_my_cate" data-ui-tab-val="tab_my_cate_3" href="javascript:;" class="bt">??? ?????? ??????</a></li>
									</ul>              
								</div>
							</div>
							<div class="ctset ctset1 active" data-ui-tab-ctn="tab_my_cate" data-ui-tab-val="tab_my_cate_1">
								<ul class="sm">
									<li><a class="bt" href="/my/pet/myPetListView" data-content="0" data-url="/my/pet/myPetListView">????????? ??????</a></li>
									<li><a class="bt" href="/mypage/tv/myWishList">?????? ????????????</a></li>
									<li><a class="bt" href="/tv/series/indexTvRecentVideo">?????? ??? ??????</a></li>
								</ul>
							</div>
							<div class="ctset ctset2" data-ui-tab-ctn="tab_my_cate" data-ui-tab-val="tab_my_cate_2">
								<ul class="sm">
									<li><a class="bt" href="/mypage/order/indexDeliveryList" data-url="/mypage/order/indexDeliveryList" data-content="0">??????/??????</a></li>
									<li><a class="bt" href="/customer/inquiry/inquiryView" data-url="/customer/inquiry/inquiryView" data-content="0">1:1 ??????</a></li>
									<li><a class="bt" href="/mypage/order/indexClaimList" data-url="/mypage/order/indexClaimList" data-content="0">??????/??????/??????</a></li>
									<li><a class="bt" href="/mypage/goodsCommentList" data-url="/mypage/goodsCommentList" data-content="0">?????? ??????</a></li>
									<li><a class="bt" href="/mypage/indexIoAlarmList" data-url="/mypage/indexIoAlarmList" data-content="0">????????? ??????</a></li>
									<li><a class="bt" href="/mypage/service/indexAddressList" data-url="/mypage/service/indexAddressList" data-content="0">????????? ??????</a></li>
									<li><a class="bt" href="/mypage/info/coupon" data-url="/mypage/info/coupon" data-content="0">??? ??????</a></li>
									<li><a class="bt" href="/mypage/order/indexBillingCardList" data-content="0">?????? ????????????</a></li>
								</ul>
							</div>
							<div class="ctset ctset3" data-ui-tab-ctn="tab_my_cate" data-ui-tab-val="tab_my_cate_3">
								<ul class="sm">
									<li><a class="bt" href="/mypage/info/indexPswdUpdate" data-content="0" data-url="/mypage/info/indexPswdUpdate" >???????????? ??????</a></li>
									<li><a class="bt" href="/mypage/info/indexManageCheck" data-content="0" data-url="/mypage/info/indexManageCheck" >???????????? ??????</a></li>
								</ul>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div class="link">
				<ul class="list">
					<li><a href="/mypage/service/coupon" data-content="0" data-url="/mypage/service/coupon" class="bt">?????????</a></li>
					<li><a href="/event/main" data-content="0" data-url="/event/main" class="bt">?????????</a></li>
					<li><a href="/customer/faq/faqList" class="bt">FAQ</a></li>
					<li><a href="/customer/notice/indexNoticeList" class="bt">????????????</a></li>
					<li><a href="/customer/notice/indexNoticeList" class="bt">?????????????????????</a></li>
				</ul>
			</div>
		</div>
	</div>
</nav>

<div class="layers tv seriesHome" id="gnbSrisListPopup"></div>

		<!-- content ?????? ???????????????.	-->	
		<!-- ????????? ?????? ???????????? ?????? : jsp:include page="/WEB-INF/tiles/b2c/include/location.jsp" -->
		<!-- ?????? - ???????????? ????????? -->
		<form id="petTvDetailForm" > 
			<input type="hidden" id="vdId" 			 name="vdId" 		   value="E2021042301050" />
			<input type="hidden" id="petGbCd" 		 name="petGbCd" 	   value="10" />
			<input type="hidden" id="eudContsCtgLCd" name="eudContsCtgLCd" value="10" />
			<input type="hidden" id="eudContsCtgMCd" name="eudContsCtgMCd" value="10" />
			<input type="hidden" id="eudContsCtgSCd" name="eudContsCtgSCd" value="10" />			
		</form>
		
         <main class="container page tv schoolDetail" id="container">
			<div class="inr" style="min-height: 531px;">			

				<!-- ?????? -->
				<div class="contents" id="contents">
                    <div class="inner-wrap">

                        <div class="pageHead black">
							<div class="inr">
								<div class="hdt">
									<button class="back" type="button" onclick="pageBack();" data-content="E2021042301050" data-url="/tv/petSchool?vdId=E2021042301050">????????????</button>
								</div>
								<div class="cent"><h2 class="subtit">${edu_title }</h2></div>
							</div>
                        </div>
                        
                        <div class="pc-subtit"><h2>${edu_title }</h2></div>

                        <div class="schoolD-wrap">

                            <div class="swiper-div">
                                <div class="swiper-container full swiper-container-initialized swiper-container-horizontal">
                                    <ul class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px);">   
                                    	<!-- ?????? --> 
                                    	<c:forEach items="${ elist }" var="eitem">
                                    	
                                    	
												 <li class="swiper-slide swiper-slide-active" style="width: 1200px;">
			                                            <div class="div-wrap ">
			                                                <!-- video-area -->
			                                                <div class="video-area">
			                                                <%--sgrplayer_body_frame" style="height: 100%;"><div style="height:calc(100% - 0px);overflow:hidden" id="div_sgrplayer_js6mbc0rwd9"><div id="fullscrenn_target" style="height:100%"><iframe id="sgrplayer_js6mbc0rwd9" name="sgrplayer_ifr" src="https://sgr.aboutpet.co.kr/player/load/z3AC115420880?vtype=mp4&amp;loop=true&amp;ui=mobile&amp;autoplay=1&amp;no_progressControl=1&amp;no_fullscreenToggle=1&amp;no_playbackRateMenuButton=1&amp;no_pictureInPictureToggle=1&amp;no_timeDisplay=1&amp;no_controlbar=1&amp;uploader_id=1&amp;viewer_id=0 --%>
			                                                    <div class="video-palyer" style="height: 100%; padding-bottom: 0px;" " >
			                                                        <div id="player0"  class="video" style="background-color:#000;">
			                                                        <div id="sgrplayer_body_frame" style="height: 100%;">
			                                                        <div style="height:calc(100% - 0px);overflow:hidden" id="div_sgrplayer_js6mbc0rwd9" >
			                                                        <div id="fullscrenn_target" style="height:100%">
			                                                       
			                                                        <iframe id="sgrplayer_js6mbc0rwd9" name="sgrplayer_ifr"  src="${eitem.v_video }" 
			                                                        frameborder="0" width="100%" height="100%" scrolling="no" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; fullscreen" allowfullscreen=""><html><head><style class="vjs-styles-defaults">
      .video-js {
        width: 300px;
        height: 150px;
      }

      .vjs-fluid {
        padding-top: 56.25%
      }
    </style><style class="vjs-styles-dimensions">
      .sgrplayer_f16xk0qo7z-dimensions {
        width: 720px;
        height: 720px;
      }

      .sgrplayer_f16xk0qo7z-dimensions.vjs-fluid {
        padding-top: 100%;
      }
    </style></head><body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">

	<link href="//sgr.aboutpet.co.kr/player/css/v1.css" rel="stylesheet">
	<!-- https://cnlqblphcryy6381644.cdn.ntruss.com/vod/z3AC115420880/video.png -->
	<div id="player_app" style="width: 100%; height: 100%;">
		<div class="vplayers h-full not_mobile ui_mobile"
			style="width: 100%; height: 100%; min-height: 80px;">
			<!---->
			<div class="pos_r h-full w-full" style="width: 100%; height: 100%;">
				<!---->
				<!---->
				<div class="cont_aea" style="display: none;"></div>
				<div class="pos_a top_tools" style="display: none;">
					<!---->
				</div>
				<div class="pos_a hand"
					style="top: 1.2em; left: 1.2em; z-index: 90; display: none;">
					<!---->
				</div>
				<!---->
				<!---->
				<!---->
				<div class="play_control_btns flex_body pl1" style="display: none;"
					is_width="800">
					<div class="btns">
						<!---->
					</div>
				</div>
				<div class="play_control_btns_playing flex_body "
					style="display: none;">
					<div class="pos_center pbtns " style="z-index: 10;">
						<div class="flex" style="align-items: center;">
							<div class="flex1 p-4" style="font-size: 1.5em;">
								<!---->
							</div>
							<div class="pos_r h-full w-full"
								style="width: 100%; height: 100%;">
								<!---->
								<!---->
								<div class="cont_aea" style="display: none;"></div>
								<!---->
								<!---->
								<!---->
								<div class="play_control_btns flex_body  pl2"
									style="display: none;">
									<div class="btns">
										<!---->
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div
					style="width: 100%; height: 100%; transition: visibility 0.1s ease 0s, opacity 0.1s ease 0s;"
					class="video-js vjs-controls-disabled vjs-workinghover vjs-v7 vjs-playing vjs-has-started sgrplayer_f16xk0qo7z-dimensions vjs-user-inactive"
					controlslist="nodownload" disablepictureinpicture=""
					disableremoteplayback="" poster="" playsinline="true" loop="true"
					autoplay="true" id="sgrplayer_f16xk0qo7z" tabindex="-1"
					role="region" lang="ko-kr" aria-label="Video Player">
					<video id="sgrplayer_f16xk0qo7z_html5_api" preload="auto"
						autoplay="" loop="" playsinline="playsinline"
						poster="${eitem.v_img }" disableremoteplayback=""
						disablepictureinpicture="" controlslist="nodownload"
						class="vjs-tech"
						style="width: 100%; height: 100%; transition: visibility 0.1s ease 0s, opacity 0.1s ease 0s;"
						tabindex="-1" role="application" src="${eitem.v_video }"></video>
					<!-- div class="vjs-poster" aria-disabled="false" 
style="background-image: url(&quot;https://cnlqblphcryy6381644.cdn.ntruss.com/vod/z3AC115420880/video.png&quot;);"></div> -->
					<div class="vjs-text-track-display" aria-live="off"
						aria-atomic="true">
						<div style="position: absolute; inset: 0px; margin: 1.5%;"></div>
					</div>
					<div class="vjs-loading-spinner vjs-hidden" dir="ltr">
						<span class="vjs-control-text">Video Player is loading.</span>
					</div>
					<button class="vjs-big-play-button" type="button"
						title="Play Video" aria-disabled="false">
						<span aria-hidden="true" class="vjs-icon-placeholder"></span><span
							class="vjs-control-text" aria-live="polite">Play Video</span>
					</button>
					<div class="vjs-error-display vjs-modal-dialog vjs-hidden "
						aria-describedby="sgrplayer_f16xk0qo7z_component_265_description"
						aria-hidden="true" aria-label="Modal Window" role="dialog">
						<p class="vjs-modal-dialog-description vjs-control-text"
							id="sgrplayer_f16xk0qo7z_component_265_description">This is a
							modal window.</p>
						<div class="vjs-modal-dialog-content" role="document"></div>
					</div>
					<div class="vjs-modal-dialog vjs-hidden  vjs-text-track-settings"
						aria-describedby="sgrplayer_f16xk0qo7z_component_270_description"
						aria-hidden="true" aria-label="Caption Settings Dialog"
						role="dialog">
						<p class="vjs-modal-dialog-description vjs-control-text"
							id="sgrplayer_f16xk0qo7z_component_270_description">Beginning
							of dialog window. Escape will cancel and close the window.</p>
						<div class="vjs-modal-dialog-content" role="document">
							<div class="vjs-track-settings-colors">
								<fieldset class="vjs-fg-color vjs-track-setting">
									<legend
										id="captions-text-legend-sgrplayer_f16xk0qo7z_component_270">Text</legend>
									<label
										id="captions-foreground-color-sgrplayer_f16xk0qo7z_component_270"
										class="vjs-label">Color</label><select
										aria-labelledby="captions-text-legend-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270"><option
											id="captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-White"
											value="#FFF"
											aria-labelledby="captions-text-legend-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-White">White</option>
										<option
											id="captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Black"
											value="#000"
											aria-labelledby="captions-text-legend-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Black">Black</option>
										<option
											id="captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Red"
											value="#F00"
											aria-labelledby="captions-text-legend-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Red">Red</option>
										<option
											id="captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Green"
											value="#0F0"
											aria-labelledby="captions-text-legend-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Green">Green</option>
										<option
											id="captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Blue"
											value="#00F"
											aria-labelledby="captions-text-legend-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Blue">Blue</option>
										<option
											id="captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Yellow"
											value="#FF0"
											aria-labelledby="captions-text-legend-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Yellow">Yellow</option>
										<option
											id="captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Magenta"
											value="#F0F"
											aria-labelledby="captions-text-legend-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Magenta">Magenta</option>
										<option
											id="captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Cyan"
											value="#0FF"
											aria-labelledby="captions-text-legend-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270 captions-foreground-color-sgrplayer_f16xk0qo7z_component_270-Cyan">Cyan</option></select><span
										class="vjs-text-opacity vjs-opacity"><label
										id="captions-foreground-opacity-sgrplayer_f16xk0qo7z_component_270"
										class="vjs-label">Transparency</label><select
										aria-labelledby="captions-text-legend-sgrplayer_f16xk0qo7z_component_270 captions-foreground-opacity-sgrplayer_f16xk0qo7z_component_270"><option
												id="captions-foreground-opacity-sgrplayer_f16xk0qo7z_component_270-Opaque"
												value="1"
												aria-labelledby="captions-text-legend-sgrplayer_f16xk0qo7z_component_270 captions-foreground-opacity-sgrplayer_f16xk0qo7z_component_270 captions-foreground-opacity-sgrplayer_f16xk0qo7z_component_270-Opaque">Opaque</option>
											<option
												id="captions-foreground-opacity-sgrplayer_f16xk0qo7z_component_270-SemiTransparent"
												value="0.5"
												aria-labelledby="captions-text-legend-sgrplayer_f16xk0qo7z_component_270 captions-foreground-opacity-sgrplayer_f16xk0qo7z_component_270 captions-foreground-opacity-sgrplayer_f16xk0qo7z_component_270-SemiTransparent">Semi-Transparent</option></select></span>
								</fieldset>
								<fieldset class="vjs-bg-color vjs-track-setting">
									<legend
										id="captions-background-sgrplayer_f16xk0qo7z_component_270">Background</legend>
									<label
										id="captions-background-color-sgrplayer_f16xk0qo7z_component_270"
										class="vjs-label">Color</label><select
										aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270"><option
											id="captions-background-color-sgrplayer_f16xk0qo7z_component_270-Black"
											value="#000"
											aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270-Black">Black</option>
										<option
											id="captions-background-color-sgrplayer_f16xk0qo7z_component_270-White"
											value="#FFF"
											aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270-White">White</option>
										<option
											id="captions-background-color-sgrplayer_f16xk0qo7z_component_270-Red"
											value="#F00"
											aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270-Red">Red</option>
										<option
											id="captions-background-color-sgrplayer_f16xk0qo7z_component_270-Green"
											value="#0F0"
											aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270-Green">Green</option>
										<option
											id="captions-background-color-sgrplayer_f16xk0qo7z_component_270-Blue"
											value="#00F"
											aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270-Blue">Blue</option>
										<option
											id="captions-background-color-sgrplayer_f16xk0qo7z_component_270-Yellow"
											value="#FF0"
											aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270-Yellow">Yellow</option>
										<option
											id="captions-background-color-sgrplayer_f16xk0qo7z_component_270-Magenta"
											value="#F0F"
											aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270-Magenta">Magenta</option>
										<option
											id="captions-background-color-sgrplayer_f16xk0qo7z_component_270-Cyan"
											value="#0FF"
											aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270 captions-background-color-sgrplayer_f16xk0qo7z_component_270-Cyan">Cyan</option></select><span
										class="vjs-bg-opacity vjs-opacity"><label
										id="captions-background-opacity-sgrplayer_f16xk0qo7z_component_270"
										class="vjs-label">Transparency</label><select
										aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-opacity-sgrplayer_f16xk0qo7z_component_270"><option
												id="captions-background-opacity-sgrplayer_f16xk0qo7z_component_270-Opaque"
												value="1"
												aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-opacity-sgrplayer_f16xk0qo7z_component_270 captions-background-opacity-sgrplayer_f16xk0qo7z_component_270-Opaque">Opaque</option>
											<option
												id="captions-background-opacity-sgrplayer_f16xk0qo7z_component_270-SemiTransparent"
												value="0.5"
												aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-opacity-sgrplayer_f16xk0qo7z_component_270 captions-background-opacity-sgrplayer_f16xk0qo7z_component_270-SemiTransparent">Semi-Transparent</option>
											<option
												id="captions-background-opacity-sgrplayer_f16xk0qo7z_component_270-Transparent"
												value="0"
												aria-labelledby="captions-background-sgrplayer_f16xk0qo7z_component_270 captions-background-opacity-sgrplayer_f16xk0qo7z_component_270 captions-background-opacity-sgrplayer_f16xk0qo7z_component_270-Transparent">Transparent</option></select></span>
								</fieldset>
								<fieldset class="vjs-window-color vjs-track-setting">
									<legend id="captions-window-sgrplayer_f16xk0qo7z_component_270">Window</legend>
									<label
										id="captions-window-color-sgrplayer_f16xk0qo7z_component_270"
										class="vjs-label">Color</label><select
										aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270"><option
											id="captions-window-color-sgrplayer_f16xk0qo7z_component_270-Black"
											value="#000"
											aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270-Black">Black</option>
										<option
											id="captions-window-color-sgrplayer_f16xk0qo7z_component_270-White"
											value="#FFF"
											aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270-White">White</option>
										<option
											id="captions-window-color-sgrplayer_f16xk0qo7z_component_270-Red"
											value="#F00"
											aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270-Red">Red</option>
										<option
											id="captions-window-color-sgrplayer_f16xk0qo7z_component_270-Green"
											value="#0F0"
											aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270-Green">Green</option>
										<option
											id="captions-window-color-sgrplayer_f16xk0qo7z_component_270-Blue"
											value="#00F"
											aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270-Blue">Blue</option>
										<option
											id="captions-window-color-sgrplayer_f16xk0qo7z_component_270-Yellow"
											value="#FF0"
											aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270-Yellow">Yellow</option>
										<option
											id="captions-window-color-sgrplayer_f16xk0qo7z_component_270-Magenta"
											value="#F0F"
											aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270-Magenta">Magenta</option>
										<option
											id="captions-window-color-sgrplayer_f16xk0qo7z_component_270-Cyan"
											value="#0FF"
											aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270 captions-window-color-sgrplayer_f16xk0qo7z_component_270-Cyan">Cyan</option></select><span
										class="vjs-window-opacity vjs-opacity"><label
										id="captions-window-opacity-sgrplayer_f16xk0qo7z_component_270"
										class="vjs-label">Transparency</label><select
										aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-opacity-sgrplayer_f16xk0qo7z_component_270"><option
												id="captions-window-opacity-sgrplayer_f16xk0qo7z_component_270-Transparent"
												value="0"
												aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-opacity-sgrplayer_f16xk0qo7z_component_270 captions-window-opacity-sgrplayer_f16xk0qo7z_component_270-Transparent">Transparent</option>
											<option
												id="captions-window-opacity-sgrplayer_f16xk0qo7z_component_270-SemiTransparent"
												value="0.5"
												aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-opacity-sgrplayer_f16xk0qo7z_component_270 captions-window-opacity-sgrplayer_f16xk0qo7z_component_270-SemiTransparent">Semi-Transparent</option>
											<option
												id="captions-window-opacity-sgrplayer_f16xk0qo7z_component_270-Opaque"
												value="1"
												aria-labelledby="captions-window-sgrplayer_f16xk0qo7z_component_270 captions-window-opacity-sgrplayer_f16xk0qo7z_component_270 captions-window-opacity-sgrplayer_f16xk0qo7z_component_270-Opaque">Opaque</option></select></span>
								</fieldset>
							</div>
							<div class="vjs-track-settings-font">
								<fieldset class="vjs-font-percent vjs-track-setting">
									<legend
										id="captions-font-size-sgrplayer_f16xk0qo7z_component_270"
										class="">Font Size</legend>
									<select
										aria-labelledby="captions-font-size-sgrplayer_f16xk0qo7z_component_270"><option
											id="captions-font-size-sgrplayer_f16xk0qo7z_component_270-50"
											value="0.50"
											aria-labelledby="captions-font-size-sgrplayer_f16xk0qo7z_component_270 captions-font-size-sgrplayer_f16xk0qo7z_component_270-50">50%</option>
										<option
											id="captions-font-size-sgrplayer_f16xk0qo7z_component_270-75"
											value="0.75"
											aria-labelledby="captions-font-size-sgrplayer_f16xk0qo7z_component_270 captions-font-size-sgrplayer_f16xk0qo7z_component_270-75">75%</option>
										<option
											id="captions-font-size-sgrplayer_f16xk0qo7z_component_270-100"
											value="1.00"
											aria-labelledby="captions-font-size-sgrplayer_f16xk0qo7z_component_270 captions-font-size-sgrplayer_f16xk0qo7z_component_270-100">100%</option>
										<option
											id="captions-font-size-sgrplayer_f16xk0qo7z_component_270-125"
											value="1.25"
											aria-labelledby="captions-font-size-sgrplayer_f16xk0qo7z_component_270 captions-font-size-sgrplayer_f16xk0qo7z_component_270-125">125%</option>
										<option
											id="captions-font-size-sgrplayer_f16xk0qo7z_component_270-150"
											value="1.50"
											aria-labelledby="captions-font-size-sgrplayer_f16xk0qo7z_component_270 captions-font-size-sgrplayer_f16xk0qo7z_component_270-150">150%</option>
										<option
											id="captions-font-size-sgrplayer_f16xk0qo7z_component_270-175"
											value="1.75"
											aria-labelledby="captions-font-size-sgrplayer_f16xk0qo7z_component_270 captions-font-size-sgrplayer_f16xk0qo7z_component_270-175">175%</option>
										<option
											id="captions-font-size-sgrplayer_f16xk0qo7z_component_270-200"
											value="2.00"
											aria-labelledby="captions-font-size-sgrplayer_f16xk0qo7z_component_270 captions-font-size-sgrplayer_f16xk0qo7z_component_270-200">200%</option>
										<option
											id="captions-font-size-sgrplayer_f16xk0qo7z_component_270-300"
											value="3.00"
											aria-labelledby="captions-font-size-sgrplayer_f16xk0qo7z_component_270 captions-font-size-sgrplayer_f16xk0qo7z_component_270-300">300%</option>
										<option
											id="captions-font-size-sgrplayer_f16xk0qo7z_component_270-400"
											value="4.00"
											aria-labelledby="captions-font-size-sgrplayer_f16xk0qo7z_component_270 captions-font-size-sgrplayer_f16xk0qo7z_component_270-400">400%</option></select>
								</fieldset>
								<fieldset class="vjs-edge-style vjs-track-setting">
									<legend id="sgrplayer_f16xk0qo7z_component_270" class="">Text
										Edge Style</legend>
									<select aria-labelledby="sgrplayer_f16xk0qo7z_component_270"><option
											id="sgrplayer_f16xk0qo7z_component_270-None" value="none"
											aria-labelledby="sgrplayer_f16xk0qo7z_component_270 sgrplayer_f16xk0qo7z_component_270-None">None</option>
										<option id="sgrplayer_f16xk0qo7z_component_270-Raised"
											value="raised"
											aria-labelledby="sgrplayer_f16xk0qo7z_component_270 sgrplayer_f16xk0qo7z_component_270-Raised">Raised</option>
										<option id="sgrplayer_f16xk0qo7z_component_270-Depressed"
											value="depressed"
											aria-labelledby="sgrplayer_f16xk0qo7z_component_270 sgrplayer_f16xk0qo7z_component_270-Depressed">Depressed</option>
										<option id="sgrplayer_f16xk0qo7z_component_270-Uniform"
											value="uniform"
											aria-labelledby="sgrplayer_f16xk0qo7z_component_270 sgrplayer_f16xk0qo7z_component_270-Uniform">Uniform</option>
										<option id="sgrplayer_f16xk0qo7z_component_270-Dropshadow"
											value="dropshadow"
											aria-labelledby="sgrplayer_f16xk0qo7z_component_270 sgrplayer_f16xk0qo7z_component_270-Dropshadow">Dropshadow</option></select>
								</fieldset>
								<fieldset class="vjs-font-family vjs-track-setting">
									<legend
										id="captions-font-family-sgrplayer_f16xk0qo7z_component_270"
										class="">Font Family</legend>
									<select
										aria-labelledby="captions-font-family-sgrplayer_f16xk0qo7z_component_270"><option
											id="captions-font-family-sgrplayer_f16xk0qo7z_component_270-ProportionalSansSerif"
											value="proportionalSansSerif"
											aria-labelledby="captions-font-family-sgrplayer_f16xk0qo7z_component_270 captions-font-family-sgrplayer_f16xk0qo7z_component_270-ProportionalSansSerif">Proportional
											Sans-Serif</option>
										<option
											id="captions-font-family-sgrplayer_f16xk0qo7z_component_270-MonospaceSansSerif"
											value="monospaceSansSerif"
											aria-labelledby="captions-font-family-sgrplayer_f16xk0qo7z_component_270 captions-font-family-sgrplayer_f16xk0qo7z_component_270-MonospaceSansSerif">Monospace
											Sans-Serif</option>
										<option
											id="captions-font-family-sgrplayer_f16xk0qo7z_component_270-ProportionalSerif"
											value="proportionalSerif"
											aria-labelledby="captions-font-family-sgrplayer_f16xk0qo7z_component_270 captions-font-family-sgrplayer_f16xk0qo7z_component_270-ProportionalSerif">Proportional
											Serif</option>
										<option
											id="captions-font-family-sgrplayer_f16xk0qo7z_component_270-MonospaceSerif"
											value="monospaceSerif"
											aria-labelledby="captions-font-family-sgrplayer_f16xk0qo7z_component_270 captions-font-family-sgrplayer_f16xk0qo7z_component_270-MonospaceSerif">Monospace
											Serif</option>
										<option
											id="captions-font-family-sgrplayer_f16xk0qo7z_component_270-Casual"
											value="casual"
											aria-labelledby="captions-font-family-sgrplayer_f16xk0qo7z_component_270 captions-font-family-sgrplayer_f16xk0qo7z_component_270-Casual">Casual</option>
										<option
											id="captions-font-family-sgrplayer_f16xk0qo7z_component_270-Script"
											value="script"
											aria-labelledby="captions-font-family-sgrplayer_f16xk0qo7z_component_270 captions-font-family-sgrplayer_f16xk0qo7z_component_270-Script">Script</option>
										<option
											id="captions-font-family-sgrplayer_f16xk0qo7z_component_270-SmallCaps"
											value="small-caps"
											aria-labelledby="captions-font-family-sgrplayer_f16xk0qo7z_component_270 captions-font-family-sgrplayer_f16xk0qo7z_component_270-SmallCaps">Small
											Caps</option></select>
								</fieldset>
							</div>
							<div class="vjs-track-settings-controls">
								<button type="button" class="vjs-default-button"
									title="restore all settings to the default values">
									Reset<span class="vjs-control-text"> restore all
										settings to the default values</span>
								</button>
								<button type="button" class="vjs-done-button">Done</button>
							</div>
						</div>
						<button class="vjs-close-button vjs-control vjs-button"
							type="button" aria-disabled="false" title="Close Modal Dialog">
							<span aria-hidden="true" class="vjs-icon-placeholder"></span><span
								class="vjs-control-text" aria-live="polite">Close Modal
								Dialog</span>
						</button>
						<p class="vjs-control-text">End of dialog window.</p>
					</div>
				</div>
				<div class="pos_a more_iframe more_ifr_small" style="display: none;">
					<div class="h-full pos_r w-full">
						<div class="more_url_toch"></div>
						<div class="pos_a text-right p-4 close_btn" style="right: 0px;">
							<i class="ph-x ft20 text-white hand"></i>
						</div>
						<!---->
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--  preload="auto" -->
<script>
    var is_fullscreen = false;
    /**/
    var controbar_options = {
        volumePanel:true,
        playToggle: true,
        progressControl:true,
        fullscreenToggle: true,
        playbackRateMenuButton: true,
        pictureInPictureToggle: true,
        currentTimeDisplay: true,
        durationDisplay: true,

    };
    /**/
    /**/
    /**/ controbar_options.fullscreenToggle = false; /**/
    /**/ controbar_options.progressControl = false; /**/
    /**/ controbar_options.playbackRateMenuButton = false; /**/
    /**/ controbar_options.pictureInPictureToggle = false; /**/
    /**/ controbar_options.currentTimeDisplay = false;  controbar_options.durationDisplay = false; /**/

    //????????? ????????????
    /**/

    function playbackrate_menu_view(){
        $(".vjs-playback-rate .vjs-menu").toggle();
    }
</script>

<script src="//sgr.aboutpet.co.kr/player/v1/code.js?v=3"></script>



<style>
    a {
        text-decoration: none;
    }
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap');
    *{
        font-family: 'Noto Sans KR', sans-serif;
    }
    .f15em{
        font-size:1.9em;
    }
</style>



</body></html></iframe><div id="sgrplayer_menu_body"><div id="sgrplayer_menu"></div><div id="sgrplayer_menu2"></div></div></div></div></div></div>
			                                                   
			                                                   
			                                                    </div>
			                                                </div>
			                                                <!-- //video-area -->
			                        
			                                                <!-- info-zone -->
			                                                <div class="info-zone" style="height: 0px;">
			                                                    <div class="info">			                                                        
			                                                        <div class="top">
			                                                            <div class="tit">${eitem.v_name}</div>
			                                                            	<div class="type" style="display:block"><!-- type ???/???  -->
			                                                                <ul> 
			                                                                    <li>
			                                                                        <strong>?????????</strong>
			                                                                        <span class="level lv${eitem.edu_diff }"><!-- ???????????? class lv1, lv2, lv3 -->
			                                                                            <span>?????????1</span>
			                                                                            <span>?????????2</span>
			                                                                            <span>?????????3</span>
			                                                                        </span>
			                                                                    </li>
			                                                                    <li>
			                                                                        <strong>?????????</strong>
			                                                                        <div class="material">
								                                                        <span>${eitem.edu_ready}</span>
																						</div>
			                                                                    </li>
			                                                                </ul>
			                                                            </div>
			                                                            </div>			                                                        
			                                                        <div class="cont">                                                        	
			                                                        	<p style="white-space: pre-line;">${eitem.v_content}</p> 
			                                                            	</div>
			                                                    </div>
			                                                    <!-- //info-zone -->
			
			                                                    <ul class="tip">
			                                                        <li>
			                                                            <a href="javascript:;" onclick="popLayer01();" class="txt-btn" data-content="layerAlert" data-url="popLayer01();">
			                                                                <div class="round-img-pf pet"></div>
			                                                                <h2>?????? ????????? ????????????????</h2>
			                                                            </a>
			                                                        </li>
			                                                        <li class="btn-rnd">
			                                                            <button type="button" onclick="popLayer02();" data-content="layerAlert" data-url="popLayer02();">Tip!</button>
			                                                            <button type="button" onclick="popLayer03();" data-content="layerAlert" data-url="popLayer03();">Q&A</button>
			                                                        </li>
			                                                    </ul>
			
			                                                    <!-- ?????? ?????????3?????? ????????? li?????? ?????? -->
			                                                    <!-- ?????? popLayer -->
			                                                    <article class="popup-layer typeA noLock" id="popLayer010" style="display:none;">
			                                                        <div class="popup-wrap">
			                                                            <div class="top">
			                                                                <h2 class="tit">?????? ????????? ????????????????</h2>
			                                                                <button type="button" class="btnPopClose" data-content="layerAlert" data-url=""><span>??????</span></button>
			                                                            </div>
			                                                            <div class="content">
			                                                                <main>			                                                                
			                                                                <img src="https://vknfvtjnsgec6381690.cdn.ntruss.com/aboutPet/images/vod/E2021042301050/30/0a97cf1d-e72a-4aca-a037-412df3e6a6ed.jpg" alt="????????????">
			                                                                	</main>
			                                                            </div>
			                                                        </div>
			                                                    </article>
			                                                    <!-- //?????? popLayer -->
			
			                                                    <!-- ??? popLayer -->
			                                                    <article class="popup-layer typeB noLock" id="popLayer020" style="height:50%;display:none;">
			                                                        <div class="popup-wrap">
			                                                            <div class="top">
			                                                                <h2 class="tit">TIP</h2>
			                                                                <button type="button" class="btnPopClose" data-content="layerAlert" data-url=""><span>??????</span></button>
			                                                            </div>
			                                                            <div class="content">
			                                                                <main>
			                                                                    <ul class="tip-list">
			                                                                       <li style="white-space: pre-line;">${eitem.edu_tip}</li>															
																						</ul>
			                                                                </main>
			                                                            </div>
			                                                        </div>
			                                                    </article>
			                                                    <!-- //??? popLayer -->
<%-- 
			                                                    <!-- QnA popLayer 
			                                                    <article class="popup-layer typeB noLock" id="popLayer030" style="height:50%;display:none;">
			                                                        <div class="popup-wrap">
			                                                            <div class="top">
			                                                                <h2 class="tit">?????? Q&A</h2>
			                                                                <button type="button" class="btnPopClose" data-content="layerAlert" data-url=""><span>??????</span></button>
			                                                            </div>
			                                                            <div class="content">
			                                                                <main>
			                                                                    <ul class="uiAccd qna-list" data-accd="accd">
			                                                                    <li class="open">
			                                                                            <div class="hBox">
			                                                                            ${eitem.eq_content}  ">"??????????????????&nbsp;?????????&nbsp;????????????&nbsp;??????&nbsp;??????&nbsp;?????????&nbsp;????????????.
			                                                                                <span class="tit" style="width:80%;">">"??????????????????&nbsp;?????????&nbsp;????????????&nbsp;??????&nbsp;??????&nbsp;?????????&nbsp;????????????</span> 
			                                                                                <button type="button" class="btnTog" data-content="layerAlert" data-url=""><span>??????</span></button>
			                                                                            </div>
			                                                                            <div class="cBox" style="">
			                                                                                                                        ????????????&nbsp;??????&nbsp;??????&nbsp;???????????????&nbsp;??????&nbsp;??????&nbsp;????????????&nbsp;?????????&nbsp;????????????.&nbsp;??????&nbsp;??????&nbsp;?????????~???&nbsp;??????&nbsp;???&nbsp;?????????&nbsp;??????????????????.&nbsp;???????????????&nbsp;???????????????&nbsp;????????????&nbsp;????????????&nbsp;???&nbsp;???&nbsp;????????????&nbsp;??????&nbsp;??????&nbsp;?????????&nbsp;?????????&nbsp;?????????&nbsp;??????.
			                                                                                <p style="white-space: pre-line;">????????????&nbsp;??????&nbsp;??????&nbsp;???????????????&nbsp;??????&nbsp;??????&nbsp;????????????&nbsp;?????????&nbsp;????????????.&nbsp;??????&nbsp;??????&nbsp;?????????~???&nbsp;??????&nbsp;???&nbsp;?????????&nbsp;??????????????????.&nbsp;???????????????&nbsp;???????????????&nbsp;????????????&nbsp;????????????&nbsp;???&nbsp;???&nbsp;????????????&nbsp;??????&nbsp;??????&nbsp;?????????&nbsp;?????????&nbsp;?????????&nbsp;??????</p>
			                                                                            </div>
			                                                                        </li>
			                                                                        <!--  
			                                                                        <li>
			                                                                            <div class="hBox">
			                                                                                <span class="tit" style="width:80%;">??????&nbsp;??????&nbsp;????????????&nbsp;??????&nbsp;??????&nbsp;??????&nbsp;????????????&nbsp;?????????&nbsp;????????????.</span> 
			                                                                                <button type="button" class="btnTog" data-content="layerAlert" data-url=""><span>??????</span></button>
			                                                                            </div>
			                                                                            <div class="cBox" style="display: none;">
			                                                                                <p style="white-space: pre-line;">????????????&nbsp;????????????&nbsp;?????????&nbsp;??????,&nbsp;??????&nbsp;??????&nbsp;?????????&nbsp;??????????????????.&nbsp;&lt;&nbsp;??????&nbsp;&gt;&nbsp;?????????&nbsp;??????&nbsp;????????????&nbsp;??????&nbsp;?????????.&nbsp;??????&nbsp;??????&nbsp;?????????&nbsp;????????????&nbsp;?????????&nbsp;????????????&nbsp;????????????&nbsp;?????????&nbsp;???&nbsp;?????????&nbsp;????????????&nbsp;??????&nbsp;??????&nbsp;?????????.</p>
			                                                                            </div>
			                                                                        </li>
			                                                                        <li>
			                                                                            <div class="hBox">
			                                                                                <span class="tit" style="width:80%;">???????????????&nbsp;?????????&nbsp;????????????&nbsp;????????????&nbsp;??????&nbsp;????????????.</span> 
			                                                                                <button type="button" class="btnTog" data-content="layerAlert" data-url=""><span>??????</span></button>
			                                                                            </div>
			                                                                            <div class="cBox" style="display: none;">
			                                                                                <p style="white-space: pre-line;">????????????&nbsp;??????&nbsp;?????????&nbsp;??????&nbsp;??????&nbsp;?????????&nbsp;???????????????.&nbsp;??????&nbsp;??????&nbsp;???????????????&nbsp;?????????&nbsp;5???&nbsp;????????????&nbsp;??????&nbsp;????????????&nbsp;???????????????,&nbsp;3???&nbsp;????????????&nbsp;??????&nbsp;????????????&nbsp;???????????????.&nbsp;???????????????&nbsp;?????????&nbsp;???&nbsp;??????&nbsp;????????????&nbsp;???&nbsp;????????????&nbsp;???????????????,&nbsp;??????&nbsp;?????????&nbsp;?????????&nbsp;???&nbsp;??????&nbsp;????????????&nbsp;?????????&nbsp;?????????.&nbsp;?????????&nbsp;???&nbsp;??????&nbsp;??????&nbsp;????????????&nbsp;????????????&nbsp;??????&nbsp;????????????.</p>
			                                                                            </div>
			                                                                        </li>
			                                                                        <li>
			                                                                            <div class="hBox">
			                                                                                <span class="tit" style="width:80%;">??????&nbsp;????????????&nbsp;?????????&nbsp;??????&nbsp;???&nbsp;???????????????&nbsp;?????????&nbsp;??????&nbsp;??????&nbsp;??????&nbsp;?????????.</span> 
			                                                                                <button type="button" class="btnTog" data-content="layerAlert" data-url=""><span>??????</span></button>
			                                                                            </div>
			                                                                            <div class="cBox" style="display: none;">
			                                                                                <p style="white-space: pre-line;">????????????&nbsp;?????????&nbsp;????????????&nbsp;??????&nbsp;??????,&nbsp;?????????&nbsp;??????&nbsp;??????&nbsp;??????&nbsp;????????????&nbsp;?????????&nbsp;???&nbsp;?????????.&nbsp;?????????&nbsp;??????&nbsp;?????????&nbsp;??????&nbsp;???????????????&nbsp;????????????&nbsp;???&nbsp;???????????????&nbsp;????????????&nbsp;???&nbsp;???&nbsp;?????????&nbsp;????????????&nbsp;?????????&nbsp;????????????&nbsp;??????.&nbsp;???&nbsp;?????????&nbsp;???????????????&nbsp;&lt;&nbsp;?????????&nbsp;2&nbsp;&gt;,&nbsp;&lt;&nbsp;?????????&nbsp;3&nbsp;&gt;&nbsp;?????????&nbsp;????????????&nbsp;???????????????&nbsp;????????????.</p>
			                                                                            </div>
			                                                                        </li>
			                                                                        --%>
			                                                                        </ul>
			                                                                        
			                                                                </main>
			                                                            </div>
			                                                        </div>
			                                                    </article>
			                                                    <!-- //QnA popLayer -->
			                                                    </div>
			                                                <!-- //info-zone -->
			                                            </div>
			                                        </li>  							
												</c:forEach>
												
			                                         
												<li class="swiper-slide" style="width: 1200px;">
													</li>
													
											</ul>
                                <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
                            </div>
                        </div>
                        <!-- //schoolD-wrap -->
                        
                        <div class="paging-wrap">
	                        	<!-- <button type="button" class="btn-prev" id="btnPrev" data-content="E2021042301050" data-url="prevVideo();" onclick="location='edu_sub.jsp'" style="visibility:hidden">?????? ????????????</button>	-->						
								<div class="swiper-pagination swiper-pagination-bullets" style="">
								<span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span>
								<span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span>
								<span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span>
								<span class="swiper-pagination-bullet" style="display: none;"></span></div>
	                            <button type="button" class="btn-blue" id="btnNext" data-content="E2021042301050" data-url="nextVideo();" onclick="">?????? ????????????</button>							
	                        </div>
                        </div><!-- //inner-wrap -->
                </div><!-- //contents -->
            </div><!-- //inr -->

             <!-- ????????? -->
             <div class="bottom-bar">
                <div class="inner">
                    <ul class="bar-btn-area">
                        <li>
                            <button class="btn-like" onclick="regLike(this);" data-content="E2021042301050" data-url="regLike(this);">3</button>
                        </li>
                    	
                    	<li>
                        	<button class="btn-share" data-message="????????? ??????????????????" id="share" title="COPY URL" data-clipboard-text="https://me2.do/FZJXiwfO" onclick="regShare(this.id);" data-content="E2021042301050" data-url="regShare(this.id);"><span>??????</span></button>
								</li>
                    	    
                        <li>                            
                            <button id="video_mark" class="btn-bookmark" onclick="fncBookToast(this);" data-content="E2021042301050" data-url="fncBookToast(this);"><span>???</span></button>
                        </li>
                    	 
                    </ul>
                    <!-- <buttron class="tvConnectedTing">????????????</buttron> -->                    
                    <!-- 2021.02.23 HTML ?????? -->
                    <buttron class="tvConnectedTing">????????????</buttron>
                    <div class="btn-with-wrap">
                        <!-- <button class="btn-with-prd" data-content="layerAlert" data-url="" onClick="ui.commentBox.open('.relation-pop');"> --><!-- 2021.02.04 : onClick????????? ?????? -->
                        <button id="videoTing" class="btn-with-prd" data-content="E2021042301050" data-url="getRelatedGoodsWithTv(this, 'E2021042301050', 'N')">    
                        	<strong style="background-image:url(https://cdudsyowwnmx6388661.cdn.ntruss.com/aboutPet/images/goods/petsbe/PI000001400/PI000001400_1.jpg?type=f&amp;w=259&amp;h=259&amp;quality=90&amp;align=4);"></strong>
                        </button>
                        <span class="num">3</span>
                    </div>
                    <!-- // 2021.02.23 HTML ?????? -->
                </div>
            </div>
            <!-- //????????? -->  
            
        </main>   
        
        <!-- 20210126 ?????? ?????? -->
        
        <script>
            var swiperFit = null;
            swiperFit = new Swiper('.schoolD-wrap .swiper-container', {
                slidesPerView: 1,
                initialSlide: 0,
               	
                simulateTouch:false,
                watchOverflow:true,
                               	
                pagination: {
                    el: '.swiper-pagination',
                },
            });
            
            swiperFit.on('slideNextTransitionStart', function() {            	
            	if(nowStepIdx == 4 ){//????????????            			
            		eduComplete();
    			}else{
    				nextStepSwipe();
    			}            	
            });            	
            	
            swiperFit.on('slidePrevTransitionStart', function() {preStepSwipe();});
            /* swiperFit.on('transitionStart', function() {            	
            	if(this.swipeDirection == "next" && nowStepIdx == 4 && !execEvent && this.previousIndex != 4){//????????????
            		eduComplete();
    			}
    			execEvent = false;    			
           	});      
            //????????? ?????????????????? ?????? ????????? transitionStart ???????????? ???????????? ?????? ?????? ?????????.	
           	swiperFit.on('orientationchange', function() {           		
           		execEvent = true;
           	});	 */           	
            
            
					setHeight();
		            $(window).resize(function(){
		                setHeight();
		            });
		            function setHeight(){
		            	var videoHeight = $(".video-area").outerHeight();
		                $(".info-zone").css("height", videoHeight);
		            };    
				

            // ?????? ???????????????
            var popLayer01 = function(){
            	var id = "popLayer01";
            	
            		id += swiperFit.realIndex;
            	            	
            	
                ui.popLayer.open(id,{
                    ocb:function(){
                    },
                    ccb:function(){                        
                    }
                });
            }

            // ??? ???????????????
            var popLayer02 = function(){
            	var id = "popLayer02";
            	
            		id += swiperFit.realIndex;
            	
            	
                ui.popLayer.open(id,{
                    ocb:function(){           
                
                    },
                    ccb:function(){        
                    	
                    }
                });
            }

            // Q&A ???????????????
            var popLayer03 = function(){
            	var id = "popLayer03";
            	
            		id += swiperFit.realIndex;
            	
            	
                ui.popLayer.open(id,{
                    ocb:function(){                        
                    },
                    ccb:function(){                        
                    }
                });
            }

            $(".btnPopClose").click(function(){
                $(this).parents(".popup-layer").hide();
            })
             
            $(".popup-layer .btnPopClose").click(function(){
                $("html").removeClass("lock");
            });
            
            /* ???????????? ?????? ???????????? */
            var startTime = 0;/* ??????????????? ???????????? ???????????? ?????? */		
			var player;
		
			
			function onIframeAPIReady() {
				//?????? ?????? ?????? ??? ???????????? ??????
				//fncLtePlay();
				
			    playSet(outVdIdArr[nowStepIdx]);
			    // === ?????? ?????????
	            sss();
	            $(window).resize(function(){
	                sss();
	            })
	            function sss(){
	                var horizontal = window.matchMedia('(orientation: landscape)').matches;
	                var h2 = $(window).innerHeight() - ($(".video-palyer").innerWidth() + 158);
	                if(horizontal){
	                    $(".info-zone").css("height","");
	                       $("body, html, #wrap.wrap").css("height","auto");
	                }else{
	                    $(".info-zone").height(h2);
	                }
	            }
			    // === ?????? ?????????
			}	
			
			function fncLtePlay(){
				if("false" == "true"){
					var cookieData = document.cookie;					
					if(cookieData.indexOf("popMwPlay=done") < 0){
						ui.confirm("3G/LTE ????????? ???????????????<br>????????? ???????????? ????????? ??? ????????????.",{ // ?????? ??? ?????????
							ycb:function(){
								autoFlag = true;
								playSet(outVdIdArr[nowStepIdx]);								
								setPlayerCookie("popMwPlay", "done" , 24 );
							},
							ncb:function(){
								autoFlag = false;
								playSet(outVdIdArr[nowStepIdx]);								
								setPlayerCookie("popMwPlay", "done" , 24 );
							},
							ybt:'??????',
							nbt:'??????'	
						});
					}else{
						playSet(outVdIdArr[nowStepIdx]);
					}
				}else{					
					playSet(outVdIdArr[nowStepIdx]);				
				}
			}
			
			function onPlaying(){}
			function onPause(){}
			function onEnded(){}
			function onMuted(state){
			    if(state==true) {
				    console.log('onMuted', '????????????');
			    }else{
				    console.log('onMuted', '???????????????');
			    }
			}
			function onActiveControlbar(state){
			    if(state==true) {			    
			    }else{			    
			    }
			}
			//???????????? 5????????? / ???????????? : sec
			function onKeepPlaying(sec){
				saveEduHistory(sec);
			}	
			
			function playSet(id){	
				player = SGRPLAYER;	
				player.setup("player"+nowStepIdx, {
					height: '100%',
					width: '100%',
					video_id: id,
					vtype:'mp4',
					loop:1,
					ui:"pc", //UI ????????? ????????? ??????
					autoplay:autoFlag, //????????????
					start_time:startTime, // 5????????? ??????
					is_ad:false, // ????????? ?????? ??????
					uploader_id:'1', //???????????? ?????? ?????????
					viewer_id:'0', //???????????? ?????? ?????????
					controlBar: {
						volumePanel:true,  //???????????????
						playToggle: true, //????????? ??????
						progressControl:false, //??????????????????
						fullscreenToggle: false, //??????????????????
						playbackRateMenuButton: false, //???????????? ??????
						pictureInPictureToggle:false,  // PIP ??????
						timeDisplay:false, //?????? ?????? ??????
					},
					events:{
						playing:onPlaying, //??????????????? ??????
						pause:onPause, // ??????????????? ??????
						ended:onEnded, //?????? ????????? ??????
						muted:onMuted, //????????? ????????? ???????????? ?????? , ?????? ????????? ??????
						keepPlaying:onKeepPlaying, //?????? ????????? , ?????? ???????????? 5????????? ??????
						//nextVideo:onNextVideo, //???????????? UI ????????? ?????? , ???????????? ??????????????? UI ?????????
						//prevVideo:onPrevVideo,  //???????????? UI ????????? ?????? , ???????????? ??????????????? UI ?????????
						activeControlbar:onActiveControlbar, //??????????????? ??????/???????????? ??????
					}
			    });
				 
			}
			
			function setPlayerCookie( name, value, expirehours ) {
				var todayDate = new Date();
				todayDate.setHours( todayDate.getHours() + expirehours );
				document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
			}
			
			/* ????????? swipe next*/
			function nextStepSwipe(){			
				cleanPlayer();
				$(".btnPopClose").click();
				playSet(outVdIdArr[++nowStepIdx]);
				btnControl(nowStepIdx);			
				saveEduHistory(0);
			}
			/* ????????? swipe prev*/
			function preStepSwipe(){			
				cleanPlayer();
				$(".btnPopClose").click();
				playSet(outVdIdArr[--nowStepIdx]);
				btnControl(nowStepIdx);
				saveEduHistory(0);
			}
			/* ?????????????????? */
			function nextVideo(){
				if(nowStepIdx == 4){//????????????							
					eduComplete();
				}else{
					swiperFit.slideNext(1, function(){nextStepSwipe()});				
				}
			}
			/* ?????????????????? */
			function prevVideo(){		
				swiperFit.slidePrev(1, function(){preStepSwipe()});
			}
			
			/* ???????????? ?????? */
			function btnControl(step){
				if(step == 0){//????????????
					$("#btnPrev").html("?????? ????????????");
					$("#btnPrev").css("visibility","hidden");
					$("#btnNext").html("?????? ????????????");
					$("#btnNext").attr("class","btn-blue");
				}else{
					$("#btnNext").html("??????");
					$("#btnPrev").css("visibility","visible");
					$("#btnPrev").html("??????");
					$("#btnNext").attr("class","btn-next");
				}
			}
			/* ???????????? ?????? */
			function cleanPlayer(){
				$("[id^='player']").empty();
				fncAutoFlag();
			}		
				
			/* ????????? ?????? ???????????? ?????? */
			function pageBack(){								
				/* if("false" == "true"){
					toNativeData.func = "onClose";					
					toNative(toNativeData);
				}else{
					history.go(-1);
				} */
				
				
				/*//??????????????? document.referrer ??????..
				if("prd" == "local"){
					if("" == "Y"){
						location.href = "/tv/petSchool";
					}else{
						history.go(-1 + (histCnt*-1));
					}
				}else{
					// ??????????????? ?????????
					if ( document.referrer && document.referrer.indexOf("aboutpet") != -1 ) { 
						if("" == "Y"){
							location.href = "/tv/petSchool";
						}else{
							history.go(-1 + (histCnt*-1));
						}
					}else {// ??????????????? ?????????, 
						if("false" == "true"){//???????????? document.referrer ??????..
							if("" == "Y"){
								location.href = "/tv/petSchool";
							}else{
								history.go(-1 + (histCnt*-1));
							}
						}else{
							location.href = "/tv/petSchool";
						}
						
					}
				}*/
				
				if("" == "Y"){
					location.href = "/tv/petSchool";
					//storageHist.goBack("/tv/petSchool");
				}else{
					//storageHist.goBack();
					storageHist.getOut("/tv/school/indexTvDetail", true);
				}
				
			}
			
			/* ?????????????????? */
			function saveEduHistory(time){				
				time = Math.floor(time);
				var mbrNo = "0";
				var nowStep = nowStepIdx;//?????? ???????????? ?????? ??????
				var nowTime = time;//?????? ?????? ??????
				
				if (mbrNo != '0') {
					petTvViewHist('E2021042301050', mbrNo,time, nowStep, "N");			    
				}
			}
			
			//????????????
			function eduComplete(){
				player.pause();
				waiting.start();
				location.href = "/tv/school/indexTvComplete?vdId=E2021042301050&histCnt="+histCnt+"&linkYn=";
				//storageHist.goBack("/tv/school/indexTvComplete?vdId=E2021042301050&histCnt="+histCnt+"&linkYn=");
			}
			
			//?????????
			function regLike(obj){
				var clickOn = $(obj).hasClass("on"); 
				var mbrNo = "0";
				if (mbrNo != '0') {
					petTvLikeDibs(obj, 'E2021042301050', mbrNo, "10"); //10:?????????, 20:???				
					/*//?????? ?????????-??????					
					if(!clickOn){						
						userActionLog('E2021042301050', "like");
					}else{						
						userActionLog('E2021042301050', "like_d");
					}*/
				}else{
					//var url = "returnUrl=/tv/school/indexTvDetail?vdId=E2021042301050";
					var url = "returnUrl=/tv/school/indexTvDetail"+ encodeURIComponent("?vdId=E2021042301050&histLoginCnt=2&histCnt=0&linkYn=");
					if ("0" == '0'){		
						url = "/indexLogin?"+url;
						showConfirm("????????? ??? ???????????? ????????? ??? ?????????.\n????????? ??????????", url);				
						return false;
					}
				}
			}
			
			function showConfirm(msg, url, loginCheck){		
				var ybtText = loginCheck != null ? "?????????" : "??????"
				ui.confirm(msg,{ // ?????? ??? ?????????
				    tit:"",
				    ycb:function(){			    	
				    	location.href = url;
				    	//storageHist.goBack(url);
				    },
				    ncb:function(){			        
				    },
				    ybt:ybtText,
				    nbt:'??????'
				});
			}
			
			//??? ???????????? ?????????
			function fncBookToast(obj){
				var clickOn = $(obj).hasClass("on"); 
				var mbrNo = "0";
				if (mbrNo != '0') {
					petTvLikeDibs(obj, 'E2021042301050', mbrNo, "20"); //10:?????????, 20:???		
					/*//?????? ?????????-??????					
					if(!clickOn){						
						userActionLog('E2021042301050', "interest");
					}else{						
						userActionLog('E2021042301050', "interest_d");
					}*/
				}else{
					//var url = "returnUrl=/tv/school/indexTvDetail?vdId=E2021042301050";
					var url = "returnUrl=/tv/school/indexTvDetail"+ encodeURIComponent("?vdId=E2021042301050&histLoginCnt=2&histCnt=0&linkYn=");
					if ("0" == '0'){		
						url = "/indexLogin?"+url;
						showConfirm("????????? ??? ???????????? ????????? ??? ?????????.\n????????? ??????????", url);				
						return false;
					}
				}			
			}
			
			//???????????? ??????
			function regShare(objId){
				petTvShare(objId, 'E2021042301050', '30');
				/*//?????? ?????????-??????
				userActionLog("E2021042301050", "share");*/
			}
			
			//???????????? APP
			function regShareApp(){		
				petTvShare("null", 'E2021042301050', '30');
				/*//?????? ?????????-??????
				userActionLog("E2021042301050", "share");*/
				
				var ttl = "????????? ???";
				ttl = ttl.replace(/amp;/gi, "");
				toNativeData.func = "onShare";
				toNativeData.image = "";//shareThumImgBase64;
				toNativeData.subject = ttl;
				toNativeData.link = "https://me2.do/FZJXiwfO";
				toNative(toNativeData);
				
			}

			//??????????????????
			function fncAutoFlag(){
				if("true" == "true"){ //PC					
					autoFlag = true;			
				}else if("false" == "true"){ //MO					
					autoFlag = false;			
				}else if("false" == "true"){ //APP					
					//?????????????????? ??????
					// ????????? ??????
					toNativeData.func = "onIsAutoPlay";
					toNativeData.callback = "appIsAutoPlay";
					// APP ??????
					toNative(toNativeData);
				}
			}
			
			//App ?????????????????????
			function appIsAutoPlay(jsonString){
				var parseData = JSON.parse(jsonString);
				var autoPlay = parseData.isAutoPlay;			
				if(autoPlay == "Y"){
					autoFlag = true;
				}else{
					autoFlag = false;
				}				
			}
			
			//????????? ??????
			function regHitCnt(){
				var options = {
			        url : "/tv/school/saveContsHit",
			        data : {
			            vdId : 'E2021042301050' //??????ID			         			            
			        },
			        async : false,
			        done : function(data){			       
			           
			        }
			    };			   
			    ajax.call(options);							
			}
			
        </script>
        <!-- //20210126 ?????? ??? -->        
        <script src="https://sgr.aboutpet.co.kr/player/iframe_api/v1.js"></script>	
<script type="text/javascript">
//??????API ?????? ?????????(????????? ?????? ?????? ??????)
function userActionLog(vdId, action){	
	var mbrNo = "0";
	if (mbrNo != "0") {
		$.ajax({
			type: 'POST'
			, url : "/common/sendSearchEngineEvent"
			, async:false
			, dataType: 'json'
			, data : {
				"logGb" : "ACTION"
				, "mbr_no" : mbrNo
				, "section" : "tv" 
				, "content_id" : vdId
				, "action" : action
				, "url" : document.location.href
				, "targetUrl" : document.location.href
				, "litd" : ""
				, "lttd" : ""
				, "prclAddr" : ""
				, "roadAddr" : ""
				, "postNoNew" : ""
				, "timestamp" : ""
			}
		});
	}
}
</script>
<%@include file="footer.jsp"%>
	</div>
</body>
</html>