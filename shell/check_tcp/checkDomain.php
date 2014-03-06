<?php
set_time_limit(0);
$bt		= microtime(true);
$arr	= array(
	"api.58game.com",	
	"egl.58game.com",
	"egl.58game.cn",
	"tq.58game.com",
	"news.58game.com",
	"news.58game.cn",
	"pk.58game.com",
	"pk.58game.cn",
	"center.58game.com",
	"www.58game.com",
	"www.58game.cn",
	"new.58game.cn",
	"58game.com",
	"58game.cn",
	"www.58youxi.com",
//	"58youxi.com",
	"bbs.stnts.com",
	"bbs.e-yoo.cn",
	"bbs.e-yoo.com",
	"bbs.yileyoo.com",
	"help.yileyoo.com",
	"help.stnts.com",
	"zhidao.stnts.com",
	"gt2.stnts.com",
	"gt2.e-yoo.cn",
	"gameol.stnts.com",
//	"hw.stnts.com",
	"2011.stnts.com",
	"wdc.stnts.com",
	"2012.stnts.com",
	"g.stnts.com",
	"pipe.stnts.com",
	"oa.e-yoo.cn",
	"oa2.e-yoo.cn",
//	"v8.stnts.com",
//	"v8wt.stnts.com",
	"song.stnts.com",
	"miao.stnts.com",
	"minisite.58game.cn",
	"www.wb123.com",
	"wb123.com",
	"webg.stnts.com",
	"58gou.stnts.com",
	"www.58taobao.cn",
	"58taobao.cn",
	"www.58gou.cn",
	"58gou.cn",
	"buy.58kankan.cn",
	"www.58ting.cn",
	"58ting.cn",
	"music.stnts.com",
	"music.58kankan.cn",
	"www.yileyoo.com",
//	"beta.yileyoo.cn",	
	"yileyoo.com",
	"beta.yileyoo.com",
	"www.yileyoo.co",
//	"yileyoo.co",
	"www.yileyoo.cc",
//	"yileyoo.cc",
	"www.yileyoo.net.cn",
//	"yileyoo.net.cn",
	"www.yileyoo.net",
	"yileyoo.net",
	"www.yileyoo.com.cn",
	"yileyoo.com.cn",
	"www.yileyoo.cn",
	"yileyoo.cn",
	"www.e-yoo.cn",
	"e-yoo.cn",
	"www.e-yoo.com",
	"e-yoo.com",
	"www.stnts.com",
	"stnts.com",
	"zhao.58game.cn",
	"show.stnts.com",
//	"tj.stnts.com",
	"kankan.stnts.com",
	"58kankan.cn",
	"www.58kankan.cn",
	"bugreports.stnts.com",
	"jl.stnts.com",
//	"yn.stnts.com",
//	"hotel.stnts.com",
	"apps.stnts.com",
	"tqm.stnts.com",
//	"vnconlinelist.stnts.com",
);

$tmp = array();
$string = "";
$ch	= curl_init();
foreach ($arr as $url) {

	// set URL and other appropriate options
	curl_setopt($ch, CURLOPT_URL, "http://$url/");
	//curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
	curl_setopt($ch, CURLOPT_HEADER, true); 
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_NOBODY, true);
	//curl_setopt($ch, CURLINFO_HEADER_OUT, true);
	curl_setopt($ch, CURLOPT_FRESH_CONNECT, true);
	curl_setopt($ch, CURLOPT_NOSIGNAL, true);
	
	//curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");
	//curl_setopt($handle, CURLOPT_HTTPHEADER, array('X-HTTP-Method-Override: PUT', 'Content-Length: ' . strlen($fields)));

	for($i = 0; $i < 5; $i++) {
		curl_exec($ch);
		$status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
		if ($status > 99 && $status < 400) break;
		else sleep(3);
	}
//	if (in_array($url, $tmp)) echo $url, "<br />";
	$tmp[$url] = $url;
	//echo "$url $status <br />";
	if ($status > 399  || $status < 100 ) $string .= "$url $status\n";
}
if ($string){
	curl_setopt($ch, CURLOPT_URL, "http://192.168.7.40/api/?action=sendmsg&uids=2660015&msg=" . urlencode($string));
	curl_exec($ch);
}
curl_close($ch);
//	mail("409183983@qq.com", "domain monitor", $string);
//echo microtime(true) - $bt;
