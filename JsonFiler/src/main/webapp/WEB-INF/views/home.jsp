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
			dataType : "json",
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
});
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
	 $.ajax({
			url : "${pageContext.request.contextPath}/GetExcelData",
			type : 'post',
			 async : false,
			success : function(ResList) {
				console.log("jfjhf",ResList)
			},
			error : function(result) {
				alert("Error in loading List");
			}
		});
	 $.ajax({
			url : "${pageContext.request.contextPath}/GetJSon",
			type : 'post',
			 async : false,
			success : function(ResList) {
				console.log("jfjhf",ResList)
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
