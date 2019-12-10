<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/jq-3.3.1/dt-1.10.18/af-2.3.3/b-1.5.6/r-2.2.2/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/bs4/jq-3.3.1/dt-1.10.18/af-2.3.3/b-1.5.6/r-2.2.2/datatables.min.js"></script>
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/dataloader/dataloader.min.js"></script>
<script src="https://www.amcharts.com/lib/3/maps/js/worldLow.js"></script>
<script type="text/javascript">
	let dataSave=[];
	$(document).ready(function() {
	/***************check if null************************/
	setData();
	$(".container").on("change","input",function(){
		var data=false;
		var allRequired = true;
		$('.required').each(function(){
		    if($(this).val() == ''){
		        allRequired = false;
		    }
		});
		if(!allRequired){
			$("#Submit").attr("disabled","disabled")
		}else{
			$("#Submit").removeAttr("disabled");
		}
	})
	/**********************Validating mail***********************************/
	$(".container").on("change",".mail",function(){
		var valueToTest =$(this).val();
		var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
		if (!testEmail.test(valueToTest))
			$(this).val("");
			alert("Invalid Email..")
	});
	/*******************Adding Rows one by one************************/
	$("#Add").on("click",function(){
		var rowLength=$("#Avil tbody tr").length+1;
		$("#Avil tbody ").append('<tr><td>'+rowLength+'</td>'
				+'<td><input class="form-control required" type=text id="fname'+rowLength+'">'
				+'<td><input class="form-control required" type=text id="lname'+rowLength+'">'
				+'<td><input class="form-control mail required" type=email id="email'+rowLength+'">'
				+'<td><input class="form-control required" type=text maxlength=10 id="phone'+rowLength+'">'
				+'<td><button class="btn btn-primary" id="delete'+rowLength+'" onclick="removeRow('+rowLength+')"><i class="fa fa-trash-o" style="font-size:20px"></i></button></tr>')
	
	          $("#Submit").attr("disabled","disabled")
	});
	/*********************Storing Data*********************/
	$("#Submit").on("click",function(){
		var dataToSend=[];
		var postparam={};
		var tblLength =$("#Avil tbody tr").length;
		for(var i=0;i<tblLength;i++){
			dataToSend.push({"firstname":$("#Avil>tbody >tr:eq("+i+") >td:eq(1)>input").val(),
				"lastname":$("#Avil>tbody >tr:eq("+i+") >td:eq(2)>input").val(),
				"email":$("#Avil>tbody >tr:eq("+i+") >td:eq(3)>input").val(),
				"phone":$("#Avil>tbody >tr:eq("+i+") >td:eq(4)>input").val()
			});
		}
		postparam ={dataToSend:dataToSend};
		$.ajax({
			url : "${pageContext.request.contextPath}/SetData",
			type : 'post',
			async : false,
			method : "post",
			dataType : "text",
			data : {
				dataStore : JSON.stringify(postparam)
			},
			success : function(resp) {
				alert(resp)
			},error : function(resp) {
				console.log("vghv",resp)
			}
		});
	});
	/*********************************************************/
	  $.ajax({
          url: '${pageContext.request.contextPath}/fetchView',
          dataType: 'json',
          success: function(resp) {
          	var date = new Date();
              var Session1 = 2019;
              var Session2 = 2020;
              var Fdate = $("#fromDate").val();
              var Tdate = $("#toDate").val();
              var To_Year = date.getFullYear();
          	var Upto_Month = ""; var count = 0;
              var calender = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
              var FCal = ['APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC', 'JAN', 'FEB', 'MAR'];
              var NewArray = []; var DumpArray = []; var GL_ID = []; var newBarGraph = []; var GLNAMES = [];
              var APR = []; var MAY = []; var JUN = []; var JUL = []; var AUG = []; var SEP = [];
              var OCT = []; var NOV = []; var DEC = []; var JAN = []; var FEB = []; var MAR = [];
              var obj1 = {}; var obj2 = {}; var obj3 = {}; var obj4 = {};
              var obj5 = {}; var obj6 = {}; var obj7 = {}; var obj8 = {};
              var obj9 = {}; var obj10 = {}; var obj11 = {}; var obj12 = {};
              $.each(resp, function (key, value) {
                  keyVal = key;
                  GLNAMES.push(resp[keyVal]['GROUP_NAME']);
                  GL_ID.push(resp[keyVal]['GROUP_ID']);
                  APR.push(resp[keyVal]['APR']); MAY.push(resp[keyVal]['MAY']);
                  JUN.push(resp[keyVal]['JUN']); JUL.push(resp[keyVal]['JUL']);
                  AUG.push(resp[keyVal]['AUG']); SEP.push(resp[keyVal]['SEP']);
                  OCT.push(resp[keyVal]['OCT']); NOV.push(resp[keyVal]['NOV']);
                  DEC.push(resp[keyVal]['DEC']); JAN.push(resp[keyVal]['JAN']);
                  FEB.push(resp[keyVal]['FEB']); MAR.push(resp[keyVal]['MAR']);
              });
              GLNAMES.unshift('MONTH')
              APR.unshift("APR-" + Session1); MAY.unshift("MAY-" + Session1); JUN.unshift("JUN-" + Session1);
              JUL.unshift("JUL-" + Session1); AUG.unshift("AUG-" + Session1); SEP.unshift("SEP-" + Session1);
              OCT.unshift("OCT-" + Session1); NOV.unshift("NOV-" + Session1); DEC.unshift("DEC-" + Session1);
              JAN.unshift("JAN-" + Session2); FEB.unshift("FEB-" + Session2); MAR.unshift("MAR-" + Session2);
              for (var k = 0; k < GLNAMES.length; k++) {
                  obj1[GLNAMES[k]] = (APR[k]).toString();
                  obj2[GLNAMES[k]] = (MAY[k]).toString();
                  obj3[GLNAMES[k]] = (JUN[k]).toString();
                  obj4[GLNAMES[k]] = (JUL[k]).toString();
                  obj5[GLNAMES[k]] = (AUG[k]).toString();
                  obj6[GLNAMES[k]] = (SEP[k]).toString();
                  obj7[GLNAMES[k]] = (OCT[k]).toString();
                  obj8[GLNAMES[k]] = (NOV[k]).toString();
                  obj9[GLNAMES[k]] = (DEC[k]).toString();
                  obj10[GLNAMES[k]] = (JAN[k]).toString();
                  obj11[GLNAMES[k]] = (FEB[k]).toString();
                  obj12[GLNAMES[k]] = (MAR[k]).toString();
              }
              NewArray.push(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11, obj12);
               if (Session2 == To_Year) {
                  Upto_Month = 12 - currMonth;
              }
              for (var i = 0; i < Upto_Month; i++) {
                  NewArray.pop();
              }
              NewArray.push(obj1, obj2, obj3, obj4, obj5, obj6, obj7, obj8, obj9, obj10, obj11, obj12);
              console.log(NewArray)
              if (Session2 == To_Year) {
                  Upto_Month = 12 - currMonth;
              }
              for (var i = 0; i < Upto_Month; i++) {
                  NewArray.pop();
              }
              console.log(GLNAMES)
              for (var i = 1; i < GLNAMES.length; i++) {
                  let graph = {};
                  graph["id"] = "v-" + GL_ID[i - 1];
                  graph["balloonText"] = GLNAMES[i] + "  [[category]] Amount:[[value]]",
                      graph["title"] = GLNAMES[i];
                  graph["valueField"] = GLNAMES[i];
                  graph["fillAlphas"] = 0.8;
                  graph["lineAlpha"] = 0.2;
                  graph["type"] = "column";
                  newBarGraph.push(graph);
              }
              function handleLegendClick(graph) {
                  var chart = graph.chart;
                  var lengthG = chart.graphs.length;
                  for (var i = 0; i < lengthG; i++) {
                      if (graph.id == chart.graphs[i].id) {
                          if (!chart.graphs[i].hidden) {
                              if (count === lengthG - 1) {
                                  chart.showGraph(chart.graphs[i]);
                              } else {
                                  chart.hideGraph(chart.graphs[i]);
                                  count++;
                              }
                          }
                          else {
                              chart.showGraph(chart.graphs[i]);
                              count--;
                          }
                      }
                  }
                  return false;
              }
              $('#toggle-Main').on('click', function () {
                  chart.graphs.forEach(function (graph) {
                      if (graph.type == "column") {
                          graph.type = "line";
                          graph.fillAlphas = 0;
                          graph.bullet = "round";
                          graph.lineAlpha = 5;
                      }
                      else {
                          graph.type = "column";
                          graph.fillAlphas = 1;
                          graph.bullet = "Not Set";
                      }
                  });
                  chart.validateData();
              });
              var chart = AmCharts.makeChart("MainGL", {
                  "type": "serial",
                  "theme": "light",
                  "categoryField": "MONTH",
                  "startDuration": 1,
                  "trendLines": [],
                  "chartScrollbar": {
                      "scrollbarHeight": 3,
                      "dragIconWidth": 15,
                      "offset": 6,
                  },
                  "valueScrollbar": {
                      "scrollbarHeight": 3,
                      "dragIconWidth": 20,
                      "oppositeAxis": false
                  },
                  "legend": {
                      "divId": "legendDiv",
                      "enabled": true,
                      "markerSize": 10,
                      "spacing": 0,
                      "fontSize": 11,
                      "useGraphSettings": true,
                      "clickMarker": handleLegendClick,
                      "clickLabel": handleLegendClick,
                  },
                  "graphs": newBarGraph,
                  "guides": [],
                  "valueAxes": [
                      {
                          "position": "left",
                          "title": "Closing"
                      }
                  ],
                  "categoryAxis": {
                      "gridPosition": "start",
                      "labelRotation": 35,
                      "title": "Months"
                  },
                  "allLabels": [],
                  "balloon": {},
                  "dataProvider": NewArray,
                  "export": {
                      "position": "top-left",
                      "enabled": true
                  },
                  "listeners": [{
                      "event": "clickGraphItem",
                      "method": function (event) {
                          $("#SubGL").empty(); $(".compSec").hide();
                          var gl_ID = (event.item.graph.id).slice(2);
                          var monthShow = event.item.category;
                          var month = (event.item.category).slice(0, 3);
                          var year = (event.item.category).slice(4, 8);
                          var calender = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
                          var monthVal = calender.indexOf(month);
                          var firstDay = new Date(year, monthVal, 1);
                          var lastDay = new Date(year, monthVal + 1, 0);
                          var LDay = parseInt(lastDay.getDate());
                          var LMonth = parseInt(lastDay.getMonth() + 1);
                          var FDay = parseInt(firstDay.getDate());
                          var FMonth = parseInt(firstDay.getMonth() + 1);
                          if (LDay < 10) {
                              LDay = "0" + LDay;
                          }
                          if (LMonth < 10) {
                              LMonth = "0" + LMonth;
                          }
                          if (FDay < 10) {
                              FDay = "0" + FDay;
                          }
                          if (FMonth < 10) {
                              FMonth = "0" + FMonth;
                          }
                          if (FMonth == "00") {
                              FMonth = "01";
                          } if (LMonth == "00") {
                              LMonth = "01";
                          }
                          var lastDayWithSlashes = LDay + '/' + LMonth + '/' + lastDay.getFullYear();
                          var FirstDayWithSlashes = FDay + '/' + FMonth + '/' + year;
                          $("#fromDate").val(FirstDayWithSlashes);
                          $("#toDate").val(lastDayWithSlashes);
                          legendText = (event.item.graph.legendTextReal);
                          $("#GLView_FDate").text("");
                          $("#GLView_FDate").append("From: " + $("#fromDate").val() + " To: " + $("#toDate").val());
                          show_SubGraph(gl_ID, month, legendText);
                          show_SubGL(gl_ID, legendText)
                      }
                  }]
              });

          },
         statusCode: {
            404: function() {
              alert('There was a problem with the server.  Try again soon!');
            }
          }
       });
});
/*******************Document over Function Starts here*******************/
function removeRow(toDelete){
	$("#delete"+toDelete).closest('tr').remove();
	$('#Avil > tbody  > tr').each(function(key,value) {
		$(this).find("td:eq(0)").text(key+1)
	});
}
/***************************************************************************/
 function setData(){
	 $.ajax({
			url : "${pageContext.request.contextPath}/GetData",
			type : 'post',
			 async : false,
			success : function(ResList) {
				let datapack= [];
				let keyVal=0;
				$.each(ResList, function(key, value) {
					keyVal=keyVal+1;
					datapack.push([keyVal,
						'<input class="form-control required" id="fname'+keyVal+'" type=text value='+ResList[key].firstname+'>',
						'<input class="form-control required" id="lname'+keyVal+'" type=text value='+ResList[key].lastname+'>',
						'<input class="form-control mail required" id="email'+keyVal+'" type=email value='+ResList[key].email+'>',
						'<input class="form-control required" id="phone'+keyVal+'" maxlength=10 type=text value='+ResList[key].phone+'>',
						'<button class="btn btn-primary" id="delete'+keyVal+'" onclick="removeRow('+keyVal+')"><i class="fa fa-trash-o" style="font-size:20px"></i></button>']		
					);
				});
				$("#Avil").DataTable({
					data:datapack,
					 responsive: true,
				})
			},
			error : function(result) {
				alert("Error in loading List");
			}
		});
}
</script>
</head>
<body>
    <div class="container">
    <h4>CoffeeBeans Task Demo</h4>
    	<div class="table-responsive">
        <table class="table table-striped table-bordered" style="width:100%" id="Avil">
		    <thead class="thead-dark">
		      <tr>
		      	<th>Sr.No</th>
		        <th>First Name</th>
		        <th>Last Name</th>
		        <th>Email</th>
		        <th>Phone</th>
		        <th>Action</th>
		      </tr>
		    </thead>
		    <tbody></tbody>
    </table>
    </div>
    <button type="button" class="btn btn-success" id="Add">
   <i class="fa fa-plus"></i>Add Row</button>
	<button type="button" class="btn btn-success" id="Submit">Success</button>
	<br><br><br>
	<div class="col-sm-6">
        <label class="switch " style="">
            <input type="checkbox" id="toggle-Main" value="B">
            <span class="slider round" data-toggle="tooltip" data-placement=""
                title="Toggle for BarGraph/LineGraph"></span>
        </label>
        <div id=MainGL style="height: 300px;width: 700px"></div>
    </div></div>
</body>
</html>
