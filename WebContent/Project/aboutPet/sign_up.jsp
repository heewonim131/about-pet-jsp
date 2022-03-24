<%@ page contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function(){

})



</script>
<script type="text/javascript">


		$(function() {
			
			// 선택 약관 팝업창 동의 버튼 클릭 시 
			$(document).on("click" , "[name=agreeTerm]" , function(){
				var checkBox =  $("#terms_"+$(this).data("terms-no"));
				if(checkBox.prop("checked")){
					checkBox.prop("checked" , false);
				}else{
					checkBox.prop("checked" , true);
				}
				
				if($(this).next().val() == "2006"){
				 	if(checkBox.prop("checked")){
				   			messager.toast({txt:"마케팅 정보 수신 약관에 동의하였어요."});
				   	}else{
				   			messager.toast({txt:"마케팅 정보 수신 약관 동의가 철회되었어요."});
				   	}
				}

				if($(this).next().val() == "2003"){
				 	if(checkBox.prop("checked")){
				   			messager.toast({txt:"위치정보 약관에 동의하였어요."});
				   	}else{
				   			messager.toast({txt:"위치정보 약관 동의가 철회되었어요."});
				   	}
				}
				
				if("PC" != "PC"){
					$("html, body").css({"overflow":"auto", "height":"auto"});	
				}
				
				
				ui.popLayer.close($(this).parents("article").attr("id"));
			})
			
			$(document).on("click" , "#closeBtn" , function(){
				if("PC" != "PC"){
					$("html, body").css({"overflow":"auto", "height":"auto"});	
				}
				$(".layers").hide();
			})
			
			// 약관 팝업창 버튼 클릭 시
			$(document).on("click" , "[name=contentPopBtn]", function(){
				$(".layers").show();
				popServiceList($(this).data("index"))
			}); 
			
			// 약관 팝업창 히스토리 변경 시 
			$(document).on("change" , "[name=termContentSelect]" , function(){
				var value =	$(this).find("option:selected").val();
				var section = $(this).parents("article").find("section");
				section.hide();
				section.eq(value).show()
			});
			
			
			if("PC" != "PC"){
				$(".mode0").remove();
				$("#footer").remove();
			}else{
				$(".mode7").remove();
			}			
			
			//전체선택 클릭 시 다 선택되도록
			$("#terms_all").click(function(){
				if($("#terms_all").is(":checked")){
					$("input:checkbox").prop("checked", true);
				}else{
					$("input:checkbox").prop("checked", false);
				}
			});
			
			//필수 약관 다 선택했는지 확인
			$("input:checkbox").click(function(){
				var isRqidAllCheck = true;
				$(".rqidTerm").each(function(index,item) {
					if(!$(item).is(":checked")) isRqidAllCheck = false;
				});
				
				var isAllCheck = true;
				$(".term").each(function(index, item){
					if(!$(item).is(":checked")) isAllCheck = false;
				});
			
				if(!isRqidAllCheck) {
					$("#inactiveBtn").show();
					$("#activeBtn").hide();
				}else{
					$("#inactiveBtn").hide();
					$("#activeBtn").show();
				}
				
				if(!isAllCheck) $("#terms_all").prop("checked",false);
				else  $("#terms_all").prop("checked",true);
				
			});
		});


		/*
	     * 약관동의 확인 후 본인인증 후 회원등록 페이지로 이동
	     */
		function goJoinPage(){
		
			var isRqidAllCheck = true;
			$(".rqidTerm").each(function(index,item) {
				if(!$(item).is(":checked")) isRqidAllCheck = false;
			});
		
			if(!isRqidAllCheck) {
				alert("필수 동의 사항 모두 동의해 주세요.");
				return;
			}
		
			var agreeTerms =[];
			$(".term").each(function(index,item) {
				var itemId = $(item).attr('id') ;
				var rcvYnVal = "N";
				if($(item).is(":checked")){
					rcvYnVal = "Y";
					if($(item).next().attr("id") == "2003") $("#pstInfoAgrYn").val("Y");
					else if($(item).next().attr("id") == "2006") $("#mkngRcvYn").val("Y");
				}
				var eachTerm = {termsNo:itemId.split("terms_")[1] , rcvYn:rcvYnVal};
				agreeTerms.push(eachTerm);
		
			});
			$("#termsNo").val(JSON.stringify(agreeTerms));
		
/* 			var emailYnVal = "N";
			var smsYnVal = "N";
			if($("#emailRcvYnChk").is(":checked")) emailYnVal = "Y";
			$("#emailRcvYn").val(emailYnVal);
			if($("#smsRcvYnChk").is(":checked")) smsYnVal = "Y";
			$("#smsRcvYn").val(smsYnVal); */		
		

			$("#vnform_terms_check_yn").val("Y");
			$("#terms_form").attr("target", "_self");
		
			//sns 회원가입인 경우는 약관 동의 후 회원정보 입력화면
			if("" != '' )  $("#snsYn").val("Y");
			
				$("#terms_form").attr("action", "/AboutPet/Project/aboutPet/join1.jsp");
				$("#terms_form").submit();
		
			/* }else{
				//일반 정회원 가입은 약관 동의 후 본인인증팝업 후 회원정보 입력화면
				ui.confirm("본인 확인을 위해 \n 휴대폰 본인인증을 해주세요." ,{
					ycb:function(){
						okCertPopup("00"); 
					},
					ybt:'본인인증하기' ,
					nbt:'취소'
				});
			}  */
		}
			
		//본인인증 콜백 함수
		function okCertCallback(result){
			var data = JSON.parse(result);
			waiting.start();
			
			if(data.RSLT_CD != "B000"){
				//messager.alert("잘못된 정보입니다. 다시 시도해 주세요.", "Info", "info");
				//alert("잘못된 정보입니다. 다시 시도해 주세요.");
				waiting.stop();
				return;
			}
			
			var today = new Date();
			var yyyy = today.getFullYear();
			var mm = today.getMonth() < 9 ? "0" + (today.getMonth() + 1) : (today.getMonth() + 1); // getMonth()
			var dd  = today.getDate() < 10 ? "0" + today.getDate() : today.getDate();
			if(parseInt(yyyy+mm+dd) - parseInt(data.RSLT_BIRTHDAY) - 140000 < 0){
				alert("만 14세 이상만 가입 가능합니다.");
				location.href ="/indexLogin";
				return;
			}
	
			$("#auth_json").val(JSON.stringify(data));
			$("#terms_form").attr("action", "/aboutPetPro/AboutPet/join1.jsp");
			$("#terms_form").submit(); 
		}
	
		
		//이용약관 레이어
	    var popServiceList = function(index){
	        // 레이어팝업 열기 콜백
	        var checkbox = $('input:checkbox[data-idx='+index+']')
	        var agreeBtn = $("button[data-terms-no="+checkbox.data('termsNo')+"]");
	     	if(checkbox.prop("checked")){
	     		agreeBtn.text("동의철회");
	     		agreeBtn.removeClass("a");
	     	}else{
	     		agreeBtn.text("동의");
	     		agreeBtn.addClass("a");
	     	}
	     	
	     	 if("PC" != "PC"){
					$("html, body").css({"overflow":"hidden", "height":"100%"});	
				}
	     	
	        ui.popLayer.open('termsContentPop'+index);
	       
		}
		
	    var popCertification = function(){
	        // 레이어팝업 열기 콜백
	        ui.popLayer.open('popCertification',{
	            ocb:function(){
	            },
	            ccb:function(){
	            }
	        });
	    }
		
	    window.history.forward();
	  //뒤에서 오기 방지
		 function noBack(){
			 window.history.forward();
		 }
	 /*  
	  function fncOkCertPopModal(){
		  var options = {
				url : "/common/okCertPop",
				data : {
					rqstCausCd : '01',
					popup : 'phone_popup2'
				},
				done : function(data){
					if(data.resultCode == 'N'){
						
					}
				}
		  }
		  ajax.call(options);
	  } */
	</script>
<style>
 .MsoNormal{
     word-wrap: break-word;
    color: #000000;
    -webkit-text-size-adjust: none;
    letter-spacing: -0.2px;
    font-family: "Roboto", "Apple SD Gothic Neo", "NotoSansKR", "Malgun Gothic", "BaseLine", Tahoma, "Dotum", "sans-serif", "apple color emoji", "segoe ui emoji", "noto color emoji", "android emoji", "emojisymbols", "emojione mozilla", "twemoji mozilla", "segoe ui symbol";
    -webkit-tap-highlight-color: transparent;
    font-size: 14rem;
    box-sizing: border-box;
    outline-color: rgb(0 114 255 / 20%);
    outline-width: 0;
    margin: 0;
    padding: 0;
    border: 0;
    max-height: 1000000px;
    margin-bottom: .0001pt;
    text-align: left;
    line-height: normal;
    background: white;
    word-break: keep-all;
 }
 .agreement{
     word-wrap: break-word;
    color: #000000;
    -webkit-text-size-adjust: none;
    letter-spacing: -0.2px;
    font-family: "Roboto", "Apple SD Gothic Neo", "NotoSansKR", "Malgun Gothic", "BaseLine", Tahoma, "Dotum", "sans-serif", "apple color emoji", "segoe ui emoji", "noto color emoji", "android emoji", "emojisymbols", "emojione mozilla", "twemoji mozilla", "segoe ui symbol";
    -webkit-tap-highlight-color: transparent;
    text-align: left;
    line-height: normal;
    word-break: keep-all;
    box-sizing: border-box;
    outline-color: rgb(0 114 255 / 20%);
    outline-width: 0;
    margin: 0;
    padding: 0;
    border: 0;
    max-height: 1000000px;
    font-size: 9.0pt;
 
 }

</style>	
	
	
</head>
<body>
<%@
include file="./header.jsp"

%>
<%@
include file="./sidebar.jsp"

%>
<script type="text/javascript">
	$(document).ready(function(){
		$("li[id^=liTag_]").one('click', function(){
			$(this).addClass("active");
	    });
		
	});
</script>
<div class="wrap" id="wrap">
				
				<!-- mobile header -->
				
		
		
				<!-- 바디 - 여기위로 템플릿 -->
				<main class="container page login srch agree" id="container">
					<div class="inr" style="min-height: 605px;">
						<form id="terms_form" method="post">
							<input type="hidden" id="auth_json" name="authJson" value="">
							
							<input type="hidden" id="snsYn" name="snsYn" value="N">
							<input type="hidden" id="vnform_terms_check_yn" name="termsCheckYn" value="N">
							<input type="hidden" id="termsNo" name="termsNos">
							<input type="hidden" id="pstInfoAgrYn" name="pstInfoAgrYn" value="N">
							<input type="hidden" id="mkngRcvYn" name="mkngRcvYn" value="N">
							<input type="hidden" name="rcomCode" value="">
						</form>
						<!-- 본문 -->
						<div class="contents" id="contents">
							<!-- PC 타이틀 모바일에서 제거  -->
							<div class="pc-tit">
								<h2>회원가입</h2>
							</div>
							<!-- // PC 타이틀 모바일에서 제거  -->
							<div class="fake-wrap">
								<div class="result"><span class="blue">서비스 이용약관에 동의</span>해주세요.</div>
								<div class="chk-wrap">
									<dl>
										<dt class="allchk">
											<label class="checkbox">
												<input type="checkbox" id="terms_all">
												<span class="txt">약관 전체동의</span>
											</label>
										</dt>
										<dd>
											<ul>
												<li>
															<label class="checkbox">
																<input type="checkbox" class="rqidTerm term" id="terms_1" data-idx="3" data-terms-no="1">
																<span class="txt" id="2001">[필수] 서비스 이용약관</span></label>
															<a href="javascript:;" name="contentPopBtn" title="내용보기" data-content="" data-url="" data-index="3"></a>
														</li>
													<li>
															<label class="checkbox">
																<input type="checkbox" class="rqidTerm term" id="terms_94" data-idx="4" data-terms-no="94">
																<span class="txt" id="2002">[필수] 개인정보 처리 방침</span></label>
															<a href="javascript:;" name="contentPopBtn" title="내용보기" data-content="" data-url="" data-index="4"></a>
														</li>
													<li>
															<label class="checkbox">
																<input type="checkbox" class="rqidTerm term" id="terms_90" data-idx="5" data-terms-no="90">
																<span class="txt" id="2007">[필수] 만 14세 이상입니다.</span></label>
															<a href="javascript:;" name="contentPopBtn" title="내용보기" data-content="" data-url="" data-index="5"></a>
														</li>
													<li>
															<label class="checkbox">
																<input type="checkbox" class="rqidTerm term" id="terms_93" data-idx="6" data-terms-no="93">
																<span class="txt" id="2008">[필수] 개인정보 수집/이용 동의</span></label>
															<a href="javascript:;" name="contentPopBtn" title="내용보기" data-content="" data-url="" data-index="6"></a>
														</li>
													<li>
															<label class="checkbox">
																<input type="checkbox" class="term" id="terms_5" data-idx="7" data-terms-no="5">
																<span class="txt" id="2003">[선택] 위치정보 동의</span></label>
															<a href="javascript:;" name="contentPopBtn" title="내용보기" data-content="" data-url="" data-index="7"></a>
														</li>
													<li>
															<label class="checkbox">
																<input type="checkbox" class="term" id="terms_9" data-idx="8" data-terms-no="9">
																<span class="txt" id="2006">[선택] 마케팅정보 수신 동의</span></label>
															<a href="javascript:;" name="contentPopBtn" title="내용보기" data-content="" data-url="" data-index="8"></a>
														</li>
													</ul>
										</dd>
									</dl>
									</div>
								<div class="info-txt pd" style="padding:10px 0px 10px 0px;font-size:12px;">
									약관 전체동의는 필수 및 선택 정보에 대한 동의도 포함되어 있으며, 개별적으로 동의를 선택하실 수 있습니다.<ul style="margin-top: 10px;">
										<li>
											필수항목에 대해서는 동의 거부 시 회원가입이 어려우며,<br> 선택항목에 대해서는 동의 거부 시에도 서비스 이용이 가능합니다.</li>
									</ul>
								</div>
								<div class="pbt fixed">
									<!-- 버튼 활성화시 -->
									<div class="bts" id="activeBtn" style="display:none;">
										<button type="button" onclick="goJoinPage();return false" class="btn xl a" data-content="" data-url="">가입하기</button>
									</div>
			
									<!-- 버튼 비활성화시 -->
									<div class="bts" id="inactiveBtn">
										<button type="button" class="btn xl gray a" data-content="" data-url="" disabeld="">가입하기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					
				</main>
				
				<div class="layers" style="display: none;">
				<!-- 이용 약관 -->
				
		
		<main class="container page login agree" id="container3">
					<div class="inr">
					<div class="contents" id="contents">
					<!-- 팝업레이어 A 전체 덮는크기 -->
					<article class="popLayer a popSample1" id="termsContentPop3" tabindex="0" style="display: none;">
						<div class="pbd">
							<div class="phd">
								<div class="in">
									<h1 class="tit">서비스 이용약관</h1>
									<button type="button" id="closeBtn" class="btnPopClose">닫기</button>
								</div>
							</div>
							<div class="pct" style="height: 661.6px;">
								<main class="poptents">
									<!-- // PC 타이틀 모바일에서 제거  -->
									<div class="agree-box">
										<div class="select">
											<select name="termContentSelect">
												<option value="0">현행 시행 일자 : 2021년 03월 17일</option>
													</select>
										</div>
										<section class="exlist">
										<dl>
										<p class="MsoNormal" align="left" style="text-align:left;line-height:normal;
mso-pagination:widow-orphan;mso-outline-level:2;background:white;text-autospace:
ideograph-numeric ideograph-other;word-break:keep-all"><span style="font-size:
18.0pt;mso-ascii-font-family:&quot;맑은 고딕&quot;;mso-ascii-theme-font:minor-fareast;
mso-hansi-font-family:&quot;맑은 고딕&quot;;mso-hansi-theme-font:minor-fareast;mso-bidi-font-family:
굴림;mso-font-kerning:0pt">이용약관<span lang="EN-US"><o:p></o:p></span></span></p><br><br>
<pre class="agreement">
제1조(목적)

표준약관 제10023호

이 약관은 (주)어바웃펫  회사(전자거래 사업자)가 운영하는 어바웃펫 사이버 몰(이하 "몰"이라 한다)에서 제공하는 인터넷 관련 서비스(이하 "서비스"라 한다)를 이용함에 있어 사이버몰과 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.
※ 「PC통신등을 이용하는 전자거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다」


제2조(정의)

① "몰"이란 (주)어바웃펫  회사가 재화 또는 용역을 이용자에게 제공하기 위하여 컴퓨터등 정보통신설비를 이용하여 재화 또는 용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.
② "이용자"란 "몰"에 접속하여 이 약관에 따라 "몰"이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
③ ‘회원’이라 함은 "몰"에 개인정보를 제공하여 회원등록을 한 자로서, "몰"의 정보를 지속적으로 제공받으며, "몰"이 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.
④ ‘비회원’이라 함은 회원에 가입하지 않고 "몰"이 제공하는 서비스를 이용하는 자를 말합니다.

⑤ ‘어바웃펫TV’이라 함은 몰에서 제공하는 반려동물 영상 콘텐츠를 말합니다.

⑥ ‘어바웃펫 LOG’이라 함은 몰에서 제공하는 커뮤니티를 말합니다
⑦ "게시물"이라 함은 회원이 서비스를 이용함에 있어 “서비스”에 게시한 부호ㆍ문자ㆍ음성ㆍ음향ㆍ화상ㆍ동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일, 링크, 댓글 등을 의미합니다.
⑧ 이 약관에서 사용하는 용어 중 본 조에서 정하지 아니한 것은 서비스 이용 시 제공되는 안내, 관계 법령에서 정하는 바에 따르며, 그 외에는 일반 관례에 따릅니다.



제3조(약관등의 명시와 설명 및 개정)

① "몰"은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호·모사전송번호·전자우편주소, 사업자등록번호, 통신판매업신고번호, 개인정보 보호책임자등을 이용자가 쉽게 알 수 있도록 "몰"의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.
② "몰"은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회·배송책임·환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.
③ "몰"은 전자상거래등에서의소비자보호에관한법률, 약관의규제에관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진등에관한법률, 방문판매등에관한법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.
④ "몰"이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일이전부터 적용일자 전일까지 공지합니다.
다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 "몰“은 개정전 내용과 개정후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.
⑤ "몰"이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간내에 "몰"에 송신하여 "몰"의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.
⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자보호지침 및 관계법령 또는 상관례에 따릅니다.


제4조(서비스의 제공 및 변경)

① "몰"은 다음과 같은 업무를 수행합니다.
1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결
2. 구매계약이 체결된 재화 또는 용역의 배송
3. 기타 "몰"이 정하는 업무
② "몰"은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.
③ "몰"이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.
④ 전항의 경우 "몰"은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, "몰"이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.
⑤ 기타 GS리테일 멤버십(THE POP) 과 관련한 내용은 GS리테일 멤버십(THE POP) 회원 약관을 준수합니다.

 



제5조(서비스의 중단)

① "몰"은 컴퓨터 등 정보통신설비의 보수점검·교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.
② "몰"은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, "몰"이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.
③ 사업종목의 전환, 사업의 포기, 업체간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 "몰"은 제8조에 정한 방법으로 이용자에게 통지하고 당초 "몰"에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, "몰"이 보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 "몰"에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다.


제6조(회원가입)

① 이용자는 "몰"이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.
② "몰"은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각호에 해당하지 않는 한 회원으로 등록합니다.
1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조제3항에 의한 회원자격 상실후 3년이 경과한 자로서 "몰"의 회원재가입 승낙을 얻은 경우에는 예외로 한다.
2. 등록 내용에 허위, 기재누락, 오기가 있는 경우
3. 기타 회원으로 등록하는 것이 "몰"의 기술상 현저히 지장이 있다고 판단되는 경우
③ 회원가입계약의 성립시기는 "몰"의 승낙이 회원에게 도달한 시점으로 합니다.
④ 회원은 제15조제1항에 의한 등록사항에 변경이 있는 경우, 즉시 전자우편 기타 방법으로 "몰"에 대하여 그 변경사항을 알려야 합니다.


제7조(회원 탈퇴 및 자격 상실 등)

① 회원은 "몰"에 언제든지 탈퇴를 요청할 수 있으며 "몰"은 즉시 회원탈퇴를 처리합니다.
② 회원이 다음 각호의 사유에 해당하는 경우, "몰"은 회원자격을 제한 및 정지시킬 수 있습니다.
1. 가입 신청시에 허위 내용을 등록한 경우
2. "몰"을 이용하여 구입한 재화등의 대금, 기타 "몰"이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우
3. 다른 사람의 "몰" 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우
4. "몰"을 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우
③ "몰"이 회원 자격을 제한·정지 시킨후, 동일한 행위가 2회이상 반복되거나 30일이내에 그 사유가 시정되지 아니하는 경우 "몰"은 회원자격을 상실시킬 수 있습니다.
④ "몰"이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.
⑤ 회원이 탈퇴하는 경우, 회원의 정보보호를 위해 탈퇴 신청일로부터 30일 후에 본인정보 및 작성한 게시물은 모두 삭제됩니다. 탈퇴 신청일로부터 30일 동안은 모든 정보와 게시물에 대해 접근이 제한되며 30일 이내에 계정 재사용 요청 시 기존 계정을 이용할 수 있습니다.
⑥ 회사는 회원이 1년 동안 로그인하지 않은 경우, 휴면계정으로 분류하고 개인정보 파기 조치를 위하여 회원탈퇴 처리할 수 있습니다.


제8조(회원에 대한 통지)

① "몰"이 회원에 대한 통지를 하는 경우, 회원이 "몰"과 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.
② "몰"은 불특정다수 회원에 대한 통지의 경우 1주일이상 "몰" 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.


제9조(구매신청) "몰"이용자는 "몰"상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, "몰"은 이용자가 구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다. 단, 회원인 경우 제2호 내지 제4호의 적용을 제외할 수 있습니다.
1. 재화등의 검색 및 선택
2. 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호) 등의 입력
3. 약관내용, 청약철회권이 제한되는 서비스, 배송료·설치비 등의 비용부담과 관련한 내용에 대한 확인
4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시(예, 마우스 클릭)
5. 재화등의 구매신청 및 이에 관한 확인 또는 "몰"의 확인에 대한 동의
6. 결제방법의 선택


제10조 (계약의 성립)

① "몰"은 제9조와 같은 구매신청에 대하여 다음 각호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.
1. 신청 내용에 허위, 기재누락, 오기가 있는 경우
2. 미성년자가 담배, 주류등 청소년보호법에서 금지하는 재화 및 용역을 구매하는 경우
3. 기타 구매신청에 승낙하는 것이 "몰" 기술상 현저히 지장이 있다고 판단하는 경우
② "몰"의 승낙이 제12조제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.
③ "몰"의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소등에 관한 정보등을 포함하여야 합니다.


제11조(지급방법) "몰"에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음 각호의 방법중 가용한 방법으로 할 수 있습니다. 단, "몰"은 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다.
1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체
2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제
3. 온라인무통장입금
4. 전자화폐에 의한 결제
5. 수령시 대금지급
6. 마일리지 등 "몰"이 지급한 포인트에 의한 결제
7. "몰"과 계약을 맺었거나 "몰"이 인정한 상품권에 의한 결제
8. 기타 전자적 지급 방법에 의한 대금 지급 등


제12조(수신확인통지·구매신청 변경 및 취소)

① "몰"은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.
② 수신확인통지를 받은 이용자는 의사표시의 불일치등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 "몰"은 배송전에 이용자의 요청이 있는 경우에는 지체없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약철회 등에 관한 규정에 따릅니다.


제13조(재화등의 공급)

① "몰"은 이용자와 재화등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, "몰"이 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 2영업일 이내에 조치를 취합니다. 이때 "몰"은 이용자가 재화등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.
② "몰"은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 "몰"이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 "몰"이 고의·과실이 없음을 입증한 경우에는 그러하지 아니합니다.


제14조(환급)

"몰"은 이용자가 구매신청한 재화등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 2영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.


제15조(청약철회 등)

① "몰"과 재화등의 구매에 관한 계약을 체결한 이용자는 수신확인의 통지를 받은 날부터 7일 이내에는 청약의 철회를 할 수 있습니다.
② 이용자는 재화등을 배송받은 경우 다음 각호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.
1. 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다)
2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우
3. 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우
4. 같은 성능을 지닌 재화등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우
③ 제2항제2호 내지 제4호의 경우에 "몰"이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회등이 제한되지 않습니다.
④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화등을 공급받은 날부터 3월이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.


제16조(청약철회 등의 효과)

① "몰"은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화등의 대금을 환급합니다. 이 경우 "몰"이 이용자에게 재화등의 환급을 지연한 때에는 그 지연기간에 대하여 공정거래위원회가 정하여 고시하는 지연이자율을 곱하여 산정한 지연이자를 지급합니다.
② "몰"은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화등의 대금을 지급한 때에는 지체없이 당해 결제수단을 제공한 사업자로 하여금 재화등의 대금의 청구를 정지 또는 취소하도록 요청합니다.
③ 청약철회등의 경우 공급받은 재화등의 반환에 필요한 비용은 이용자가 부담합니다. "몰"은 이용자에게 청약철회등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회등을 하는 경우 재화등의 반환에 필요한 비용은 "몰"이 부담합니다.
④ 이용자가 재화등을 제공받을때 발송비를 부담한 경우에 "몰"은 청약철회시 그 비용을 누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.


제17조(개인정보보호)

① "몰"은 이용자의 정보수집시 구매계약 이행 및 서비스이용에 필요한 최소한의 정보를 수집합니다. 다음 사항을 필수사항으로 하며 그 외 사항은 선택사항으로 합니다.
1. 성명
2. 주소
3. 전화번호
4. 희망ID(회원의 경우)
5. 비밀번호(회원의 경우)
6. 전자우편주소(또는 이동전화번호)

7. 위치정보(회원이 어바웃펫LOG에 사진 업로드하는 경우)
② "몰"이 이용자의 개인식별이 가능한 개인정보를 수집하는 때에는 반드시 당해 이용자의 동의를 받습니다.
③ 제공된 개인정보는 당해 이용자의 동의없이 목적외의 이용이나 제3자에게 제공할 수 없으며, 이에 대한 모든 책임은 몰이 집니다. 다만, 다음의 경우에는 예외로 합니다.
1. 배송업무상 배송업체에게 배송에 필요한 최소한의 이용자의 정보(성명, 주소, 전화번호)를 알려주는 경우
2. 통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로 제공하는 경우
3. 재화등의 거래에 따른 대금정산을 위하여 필요한 경우
4. 도용방지를 위하여 본인확인에 필요한 경우
5. 법률의 규정 또는 법률에 의하여 필요한 불가피한 사유가 있는 경우
④ "몰"이 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보 보호책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 정보통신망이용촉진등에관한법률 제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.
⑤ 이용자는 언제든지 "몰"이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 "몰"은 이에 대해 지체없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 "몰"은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.
⑥ "몰"은 개인정보 보호를 위하여 관리자를 한정하여 그 수를 최소화하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.
⑦ "몰" 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체없이 파기합니다.


제18조(“몰“의 의무)

① "몰"은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화·용역을 제공하는데 최선을 다하여야 합니다.
② "몰"은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.
③ "몰"이 상품이나 용역에 대하여 「표시·광고의공정화에관한법률」 제3조 소정의 부당한 표시·광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.
④ "몰"은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.


제19조(회원의 ID 및 비밀번호에 대한 의무)

① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.
② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.
③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 "몰"에 통보하고 "몰"의 안내가 있는 경우에는 그에 따라야 합니다.


제20조(이용자의 의무) 이용자는 다음 행위를 하여서는 안됩니다.
1. 신청 또는 변경시 허위 내용의 등록
2. 타인의 정보 도용
3. "몰"에 게시된 정보의 변경
4. "몰"이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시
5. "몰" 기타 제3자의 저작권 등 지적재산권에 대한 침해
6. "몰" 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 몰에 공개 또는 게시하는 행위
8. 다른 회원을 희롱 또는 위협하거나, 특정 회원에게 지속적으로 고통 또는 불편을 주는 행위


제21조(연결"몰"과 피연결"몰" 간의 관계)

① 상위 "몰"과 하위 "몰"이 하이퍼 링크(예: 하이퍼 링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등으로 연결된 경우, 전자를 연결 "몰"(웹 사이트)이라고 하고 후자를 피연결 "몰"(웹사이트)이라고 합니다.
② 연결"몰"은 피연결"몰"이 독자적으로 제공하는 재화등에 의하여 이용자와 행하는 거래에 대해서 보증책임을 지지 않는다는 뜻을 연결"몰"의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한 보증책임을 지지 않습니다.


제22조(저작권의 귀속 및 이용제한)

① “몰“이 작성한 저작물에 대한 저작권 기타 지적재산권은 ”몰“에 귀속합니다.
② 이용자는 "몰"을 이용함으로써 얻은 정보 중 "몰"에게 지적재산권이 귀속된 정보를 "몰"의 사전 승낙없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.
③ "몰"은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.
④ 회사는 회원이 서비스 내에 게시한 게시물이 관련 법령에 위반되거나 음란 또는 청소년에게 유해한 게시물, 차별 갈등을 조장하는 게시물, 도배 · 광고 · 홍보 · 스팸성 게시물, 계정을 양도 또는 거래하는 내용의 게시물, 타인을 사칭하는 게시물 등이라고 판단되는 경우 이를 삭제하거나 게시를 거부할 수 있습니다. 


제23조 (개인정보의 목적 외 이용 및 위탁)

 

① 회사는 이용자의 개인정보를 “제 17조 개인정보보호정책” 에서 고지한 범위 내에서 사용하며 동 범위를 초과하여 이용하거나 원칙적으로 제 3자에게 제공하지 않습니다.

다만 다음의 경우에는 합당한 절차를 통한 회원의 동의를 얻어 개인정보를 제공 또는 이용할 수 있습니다.

② 회사는 보다 나은 서비스 제공을 위하여 회원의 개인정보를 제휴사에 제공할 수 있습니다. 이 경우 회원에게 개인정보의 항목, 개인정보 제공 목적, 제공기간, 개인정보보호방안 등에 대해서 사전에 개별적으로 동의를 구하는 절차를 거치게 되며, 회원의 동의가 없는 경우에 이를 제공하지 않습니다.

③ 회사는 보다 나은 서비스 제공을 위하여 회원의 개인정보를 위탁하여 처리할 수 있으며, 이 경우 반드시 사전에 위탁처리 업체명과 목적, 위탁처리 되는 개인정보의 범위, 위탁기간 등에 대해 상세하게 고지합니다.

④ 단, 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우에는 사전 동의 없이 제공될 수 있습니다.

 


제24조(분쟁해결)

① "몰"은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치·운영합니다.
② "몰"은 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.
③ "몰"과 이용자간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.


제25조(재판권 및 준거법)

① "몰"과 이용자간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.
② "몰"과 이용자간에 제기된 전자상거래 소송에는 한국법을 적용합니다.


 

 



부칙

1. 이 약관은 2021년 4월 30일부터 적용됩니다.
</pre>

										
										</dl>
										
											</section>
											</div>
								</main>
							</div>
						</div>
					</article>
				</div>
			</div>
		</main>
		
		<!-- 이용 약관 -->
				<main class="container page login agree" id="container4">
					<div class="inr">
					<div class="contents" id="contents">
					<!-- 팝업레이어 A 전체 덮는크기 -->
					<article class="popLayer a popSample1" id="termsContentPop4">
						<div class="pbd">
							<div class="phd">
								<div class="in">
									<h1 class="tit">개인정보 처리 방침</h1>
									<button type="button" id="closeBtn" class="btnPopClose">닫기</button>
								</div>
							</div>
							<div class="pct">
								<main class="poptents">
									<!-- // PC 타이틀 모바일에서 제거  -->
									<div class="agree-box">
										<div class="select">
											<select name="termContentSelect">
												<option value="0">현행 시행 일자 : 2021년 06월 03일</option>
													<option value="1">2021년 03월 17일 ~ 2021년 06월 03일</option>
													</select>
										</div>
										<section class="exlist">
												<span class="agreement">
												
<p>(주)어바웃펫은 이용자의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 다음과 같이 개인정보 처리방침을 수립·공개하며, 본 개인정보 처리방침을 홈페이지 첫 화면에 공개함으로써 이용자들이 언제나 용이하게 보실 수 있도록 조치하고 있습니다. 개인정보 처리방침은 정부의 법률 및 지침 변경이나 회사의 내부 방침 변경 등으로 인하여 수시로 변경될 수 있고, 이에 따른 개인정보 처리방침의 지속적인 개선을 위하여 필요한 절차를 정하고 있습니다. 이용자들께서는 사이트 방문 시 수시로 확인하시기 바랍니다.</p> 
<br>
<br>
(주)어바웃펫의 개인정보 처리방침은 다음과 같은 내용을 담고 있습니다.
<br>
1. 개인정보 수집에 대한 동의<br>
2. 수집하는 개인정보 항목 및 수집방법<br>
3. 개인정보의 수집 및 이용목적<br>
4. 수집하는 개인정보의 보유 및 이용기간<br>
5. 개인정보의 파기 절차 및 방법<br>
6. 수집한 개인정보의 공유 및 제공<br>
7. 이용자 자신의 개인정보 관리(열람,정정,삭제 등)에 관한 사항<br>
8. 쿠키(Cookie)의 운용 및 거부<br>
9. 개인정보의 제3자 제공<br>
10. 개인정보의 처리 위탁<br>
11. 개인정보보호를 위한 기술적/관리적 대책<br>
12. 개인정보 관련 의견수렴 및 불만처리에 관한 사항<br>
13. 개인정보 보호책임자 및 담당자의 소속-성명 및 연락처<br>
14. 이용자 및 법정대리인의 권리와 그 행사방법<br>
15. 권익침해 구제방법<br>
16. 고지의 의무<br>
<br>
<br>
<p>
1. 개인정보 수집에 대한 동의
(주)어바웃펫은 이용자들이 회사의 개인정보수집이용 동의 또는 이용약관의 내용에 대하여 「동의」버튼 또는 「취소」버튼을 클릭할 수 있는 절차를 마련하여, 「동의」버튼을 클릭하면 개인정보 수집에 대해 동의한 것으로 봅니다.
</p>
2. 수집하는 개인정보의 항목 및 수집방법
가. 수집 항목
												</span>
											</section>
											</div>
								</main>
							</div>
						</div>
					</article>
				</div>
			</div>
		</main>
		<!-- 이용 약관 -->
				<main class="container page login agree" id="container5">
					<div class="inr">
					<div class="contents" id="contents">
					<!-- 팝업레이어 A 전체 덮는크기 -->
					<article class="popLayer a popSample1" id="termsContentPop5">
						<div class="pbd">
							<div class="phd">
								<div class="in">
									<h1 class="tit">만 14세 이상입니다.</h1>
									<button type="button" id="closeBtn" class="btnPopClose">닫기</button>
								</div>
							</div>
							<div class="pct">
								<main class="poptents">
									<!-- // PC 타이틀 모바일에서 제거  -->
									<div class="agree-box">
										<div class="select">
											<select name="termContentSelect">
												<option value="0">현행 시행 일자 : 2021년 04월 30일</option>
													</select>
										</div>
										<section class="exlist">
												<dl>
													<p>만 14세 이상입니다.&nbsp;</p></dl>
											</section>
											</div>
								</main>
							</div>
						</div>
					</article>
				</div>
			</div>
		</main>
		<!-- 이용 약관 -->
				<main class="container page login agree" id="container6">
					<div class="inr">
					<div class="contents" id="contents">
					<!-- 팝업레이어 A 전체 덮는크기 -->
					<article class="popLayer a popSample1" id="termsContentPop6">
						<div class="pbd">
							<div class="phd">
								<div class="in">
									<h1 class="tit">개인정보 수집/이용 동의</h1>
									<button type="button" id="closeBtn" class="btnPopClose">닫기</button>
								</div>
							</div>
							<div class="pct">
								<main class="poptents">
									<!-- // PC 타이틀 모바일에서 제거  -->
									<div class="agree-box">
										<div class="select">
											<select name="termContentSelect">
												<option value="0">현행 시행 일자 : 2021년 05월 06일</option>
													</select>
										</div>
										<section class="exlist">
												<dl>
													
											</section>
											</div>
								</main>
							</div>
						</div>
					</article>
				</div>
			</div>
		</main>
		<!-- 이용 약관 -->
				<main class="container page login agree" id="container7">
					<div class="inr">
					<div class="contents" id="contents">
					<!-- 팝업레이어 A 전체 덮는크기 -->
					<article class="popLayer a popSample1" id="termsContentPop7">
						<div class="pbd">
							<div class="phd">
								<div class="in">
									<h1 class="tit">위치정보 동의</h1>
									<button type="button" id="closeBtn" class="btnPopClose">닫기</button>
								</div>
							</div>
							<div class="pct">
								<main class="poptents">
									<!-- // PC 타이틀 모바일에서 제거  -->
									<div class="agree-box">
										<div class="select">
											<select name="termContentSelect">
												<option value="0">현행 시행 일자 : 2021년 03월 17일</option>
													</select>
										</div>
										<div class="agree-btn" style="margin-top:20px;">
												<p class="txt">위치정보 동의약관에 동의할까요?</p>
												<button name="agreeTerm" id="agreeTermModal" class="btn a" data-terms-no="5">동의</button>
												<input type="hidden" value="2003">
											</div>
										<section class="exlist">
												
											</section>
											</div>
								</main>
							</div>
						</div>
					</article>
				</div>
			</div>
		</main>
		<!-- 이용 약관 -->
				<main class="container page login agree" id="container8">
					<div class="inr">
					<div class="contents" id="contents">
					<!-- 팝업레이어 A 전체 덮는크기 -->
					<article class="popLayer a popSample1" id="termsContentPop8">
						<div class="pbd">
							<div class="phd">
								<div class="in">
									<h1 class="tit">마케팅정보 수신 동의</h1>
									<button type="button" id="closeBtn" class="btnPopClose">닫기</button>
								</div>
							</div>
							<div class="pct">
								<main class="poptents">
									<!-- // PC 타이틀 모바일에서 제거  -->
									<div class="agree-box">
										<div class="select">
											<select name="termContentSelect">
												<option value="0">현행 시행 일자 : 2021년 03월 17일</option>
													</select>
										</div>
										<div class="agree-btn" style="margin-top:20px;">
												<p class="txt">마케팅정보 수신 동의약관에 동의할까요?</p>
												<button name="agreeTerm" id="agreeTermModal" class="btn a" data-terms-no="9">동의</button>
												<input type="hidden" value="2006">
											</div>
										<section class="exlist">
												<dl>
													<p class="MsoNormal" align="left" style="text-align:left;line-height:normal;
mso-pagination:widow-orphan;background:white;text-autospace:ideograph-numeric ideograph-other;
word-break:keep-all"><span style="font-size:9.0pt;
mso-ascii-font-family:" 맑은="" 고딕";mso-ascii-theme-font:minor-fareast;mso-hansi-font-family:="" "맑은="" 고딕";mso-hansi-theme-font:minor-fareast;mso-bidi-font-family:굴림;color:black;="" mso-font-kerning:0pt"="">맞춤서비스<span lang="EN-US">, </span>할인정보 등 정보 수신<span lang="EN-US"><o:p></o:p></span></span></p>

<p class="MsoNormal" align="left" style="margin-bottom:0cm;margin-bottom:.0001pt;
text-align:left;line-height:normal;mso-pagination:widow-orphan;background:white;
text-autospace:ideograph-numeric ideograph-other;word-break:keep-all"><span lang="EN-US" style="font-size:9.0pt;mso-ascii-font-family:" 맑은="" 고딕";mso-ascii-theme-font:="" minor-fareast;mso-hansi-font-family:"맑은="" 고딕";mso-hansi-theme-font:minor-fareast;="" mso-bidi-font-family:굴림;color:black;mso-font-kerning:0pt"="">SMS</span><span style="font-size:9.0pt;mso-ascii-font-family:" 맑은="" 고딕";mso-ascii-theme-font:minor-fareast;="" mso-hansi-font-family:"맑은="" 고딕";mso-hansi-theme-font:minor-fareast;mso-bidi-font-family:="" 굴림;color:black;mso-font-kerning:0pt"="">과 이메일 수신 동의 시<span lang="EN-US">, </span>회원님들만을
위해 준비된 이벤트<span lang="EN-US">, </span>할인 소식을 받으실 수 있습니다<span lang="EN-US">.<o:p></o:p></span></span></p></dl>
											</section>
											</div>
								</main>
							</div>
						</div>
					</article>
				</div>
			</div>
		</main>
		</div>
	</div>




<%@
include file="./footer.jsp"

%>


</body>
</html>