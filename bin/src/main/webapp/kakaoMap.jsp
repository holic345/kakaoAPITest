<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 맵</title>
</head>
<body>
	<div id="map" style="width:100%;height:100vh;"></div>	<!-- 전체화면으로 설정 -->
	
<!-- 스크립트의 이 부분을 문서의 맨 끝에 두어 문서가 이미 로드되기 전의 모든 것이 되도록 하는 것 필요 -->
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=66de1c95d1d79be93897b045b9aca54a&libraries=services,clusterer,drawing"></script>
<script type="text/javascript">
	var mapContainer = document.getElementById("map");
	var mapOption = {
		center: new kakao.maps.LatLng(37.57056001779529, 126.99046810138731),
		level: 4,	//지도의 확대 레벨
		mapTypeId: kakao.maps.MapTypeId.ROADMAP	//지도 종류
	};
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 마커 클러스터러를 생성합니다 
	var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 10 // 클러스터 할 최소 지도 레벨 
    });
	
	var data = [
		[37.57056001779529, 126.99046810138731,'<div style="padding:5px;">맥도날드 종로3가점 McDonald\'s</div>'],
		[37.57311655456051, 127.01510539116606,'<div style="padding:5px;">맥도날드 서울동묘역점 McDonald\'s</div>'],
		[37.56416674801353, 126.9844438972081,'<div style="padding:5px;">맥도날드 명동점 McDonald\'s</div>']
	];
	
	var markers = [];
	
	for(var i = 0; i < data.length; i++) {
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: new kakao.maps.LatLng(data[i][0], data[i][1]),	// 마커가 표시될 위치입니다 
		    map: map	// 마커가 지도 위에 표시되도록 설정합니다
		});

		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);    
		
		//var iwContent = '<div style="padding:5px;">맥도날드 종로3가점 McDonald\'s</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    //iwPosition = new kakao.maps.LatLng(33.450701, 126.570667); //인포윈도우 표시 위치입니다, marker에서 위치 저장했기때문에 삭제

		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
			//marker에서 위치 저장했기때문에 position 부분은 삭제
		    content : data[i][2]
		});
		  
		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		//infowindow.open(map, marker); 
		
		markers.push(marker);	//markers라는 변수안에 marker라는 마커를 집어넣음
		
		// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    kakao.maps.event.addListener(
	   		marker, 
	   		'mouseover', 
	   		makeOverListener(map, marker, infowindow)
	    );
	    kakao.maps.event.addListener(
    		marker, 
    		'mouseout', 
    		makeOutListener(infowindow)
	    );
	}
	
	// 클러스터러에 마커들을 추가합니다
	clusterer.addMarkers(markers);
	
	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
	
</script>
</body>
</html>