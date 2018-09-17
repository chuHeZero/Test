var inval;
var interval1 = 01;
var interval2 = 59;
var interval3 = 59;
$(function() {
	setInterval(function() {
		$(".interval3").text(interval3);
		$(".interval2").text(interval2);
		$(".interval1").text(interval1);
		interval3--;
		if (interval3 < 0) {
			interval3 = 59;
			interval2--;
			if (interval2 < 0) {
				interval2 = 59;
				interval1--;
				if (interval1 < 0)
					interval1 = 12;
			}
		}
	}, 1000)
	$(".imglist img").hide();
	$("img[src='img/1.jpg']").show();

	inval = setInterval("nextimg()", 3000);
	$(".imglist").mouseover(function() {
		clearInterval(inval);
	});
	$(".imglist").mouseout(function() {
		inval = setInterval("nextimg()", 3000);
	});
	
	//计算购物车商品数量
	getcartcount();
});
var index = 1;

function listimg() {
	index--;
	if (index < 1) {
		index = 4;
	}
	showimgbyindex(index);
}

function nextimg() {
	index++;
	if (index > 4) {
		index = 1;
	}
	showimgbyindex(index);
}

function showimgbyindex(index) {
	$(".imglist img").fadeOut(1000);
	if (index == 1) {
		$("img[src='img/1.jpg']").fadeIn(1000);
	}
	if (index == 2) {
		$("img[src='img/2.jpg']").fadeIn(1000);
	}
	if (index == 3) {
		$("img[src='img/3.jpg']").fadeIn(1000);
	}
	if (index == 4) {
		$("img[src='img/4.jpg']").fadeIn(1000);
	}
}
var index2 = 1;
function skbdnextImg() {
	if (index2 == 0) {
		$(".sk_bd .sk_bdimg").css("left", "0px");
		$(".sk_bd .sk_bdimg").animate({
			"left" : "-805px"
		}, 1000);
		index2 = 1;
	} else {
		index2++;
		if (index2 == 7) {
			index2 = 2;
		}
		ShowskbdImgByIndex(index2);
	}

}
function skbdlastImg() {
	if (index2 == 6) {
		$(".sk_bd .sk_bdimg").css("left", "-4820px");
		$(".sk_bd .sk_bdimg").animate({
			"left" : "-4020px"
		}, 1000);
		index2 = 5;
	} else {
		index2--;
		if (index2 == -1) {
			index2 = 4;
		}
		ShowskbdImgByIndex(index2);
	}

}
function ShowskbdImgByIndex(i) {
	if (i == 0) {
		$(".sk_bd .sk_bdimg").css("left", "-4820px");
		$(".sk_bd .sk_bdimg").animate({
			"left" : "-4020px"
		}, 1000);
	}
	if (i == 1) {
		$(".sk_bd .sk_bdimg").animate({
			"left" : "-805px"
		}, 1000);

	}
	if (i == 2) {
		$(".sk_bd .sk_bdimg").animate({
			"left" : "-1605px"
		}, 1000);
	}
	if (i == 3) {
		$(".sk_bd .sk_bdimg").animate({
			"left" : "-2410px"
		}, 1000);
	}
	if (i == 4) {
		$(".sk_bd .sk_bdimg").animate({
			"left" : "-3215px"
		}, 1000);
	}
	if (i == 5) {
		$(".sk_bd .sk_bdimg").animate({
			"left" : "-4020px"
		}, 1000);
	}
	if (i == 6) {
		$(".sk_bd .sk_bdimg").css("left", "0px");
		$(".sk_bd .sk_bdimg").animate({
			"left" : "-805px"
		}, 1000);
	}
}
var index3 = 1;
$(function() {

	setInterval(function() {
		index3++;
		if (index3 == 2) {
			$(".sk_chn .chnimg").animate({
				"left" : "-185px"
			}, 500);
		}
		if (index3 == 3) {
			$(".sk_chn .chnimg").animate({
				"left" : "-379px"
			}, 500);
		}
		if (index3 == 4) {
			$(".sk_chn .chnimg").css("left", "10px");
			$(".sk_chn .chnimg").animate({
				"left" : "-185px"
			}, 500);
			index3 = 2;
		}
	}, 3000);

});
function getcartcount(){
	//先去cookie中取存有count的cookie
	var ckicart = $.cookie("cart");
	var cart;
	if(ckicart==undefined){
		//当购物车信息为空时，创建一个购物车数组保存信息
		$("#cartnb").text(0);
	}else{
		cart = JSON.parse(ckicart);
		
		var sum = 0;
		for(var i=0; i<cart.length; i++){
			sum += parseInt(cart[i].count);
		}
		$("#cartnb").text(sum);
	}
}
