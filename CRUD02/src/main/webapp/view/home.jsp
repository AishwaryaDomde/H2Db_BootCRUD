<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
    <link href="webjars/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="webjars/jquery/3.4.1/jquery.min.js"></script>
    <script src="webjars/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css"
        href="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.10.20/af-2.3.4/b-1.6.1/b-html5-1.6.1/b-print-1.6.1/fc-3.3.0/kt-2.5.1/r-2.2.3/rr-1.2.6/sc-2.0.1/sl-1.3.1/datatables.min.css" />
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
    <script type="text/javascript"
        src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.10.20/af-2.3.4/b-1.6.1/b-html5-1.6.1/b-print-1.6.1/fc-3.3.0/kt-2.5.1/r-2.2.3/rr-1.2.6/sc-2.0.1/sl-1.3.1/datatables.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script>
        $(document).ready(function () {
            var candidates_data = [];
            $.each(JSON.parse($("#candidates_data").text()), function (key, val) {
                candidates_data.push([
                    val.first_name,
                    val.last_name,
                    val.email,
                    '<a class="btn btn-warning" href = "${pageContext.request.contextPath}/MCandidate/'+val.id+'"><i class="fa fa-edit" style="font-size:24px"></i></a>',
                    '<a class="btn btn-warning" href = "${pageContext.request.contextPath}/DCandidate/'+val.id+'"><i class="fa fa-trash" style="font-size:24px"></i></a>',

                ])
            });
            var Userdata = [];
            $.each(JSON.parse($("#Userdata").text()), function (key, val) {
                Userdata.push([
                    val.user_first_name,
                    val.user_last_name,
                    val.user_email,
                    '<a class="btn btn-warning" href = "${pageContext.request.contextPath}/employee/'+val.user_id+'"><i class="fa fa-edit" style="font-size:24px"></i></a>',
                    '<a class="btn btn-warning" href = "${pageContext.request.contextPath}/delete/'+val.user_id+'"><i class="fa fa-trash" style="font-size:24px"></i></a>',

                ])
            });
            $('#tbl1').DataTable({
                data: candidates_data,
                "autoWidth": false,
                deferRender: true,
                pageLength: 10,
                "bLengthChange": false,
                info: false,
                scrollCollapse: true,
                responsive: true
            });
            $('#tbl2').DataTable({
                data: Userdata,
                "autoWidth": false,
                deferRender: true,
                pageLength: 10,
                "bLengthChange": false,
                info: false,
                scrollCollapse: true,
                responsive: true
            });
            $("#Submit").on("click", function () {
                var data = $('form').serialize();console.log(data);
                var postparam = {
                    "user_id": (typeof ($("#user_id").val()) == "undefined" ? "" : $("#user_id").val()),
                    "user_email": $("#user_email").val(),
                    "user_first_name": $("#user_first_name").val(),
                    "user_last_name": $("#user_last_name ").val()
                }
                $.ajax({
                    url: "${pageContext.request.contextPath}/SaveDetails",
                    data: JSON.stringify(postparam),
                    method: "post",
                    dataType: "json",
                    contentType: "application/json",
                    success: function (resp) {
                        console.log(resp)
                    }
                });
            })
            $('#signup').on("submit", function(event) {
   // $form = $(this); //wrap this in jQuery

    console.log('the action is: ' );
});
        })
    </script>
</head>

<body>
    Hi Aliens...
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <form modelAttribute="candidate" action="${pageContext.request.contextPath}/save" method="POST" id="funform">
                    <div class="form-group">
                        <label for="email">Email address:</label>
                        <input type="email" class="form-control" placeholder="Enter email" id="email" name=email>
                    </div>
                    <div class="form-group">
                        <label for="pwd">first name:</label>
                        <input type="text" class="form-control" placeholder="Enter password" id="first_name"
                            name=first_name>
                    </div>
                    <div class="form-group">
                        <label for="pwd">last name:</label>
                        <input type="text " class="form-control" placeholder="Enter password" id="last_name"
                            name="last_name">
                    </div>
                    <input id='id' name="id" hidden>
                    <button type="submit" class="btn btn-primary" id =signup>Submit</button>
                </form>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label for="email">Email address:</label>
                    <input type="email" class="form-control" placeholder="Enter email" id="user_email" name=email>
                </div>
                <div class="form-group">
                    <label for="pwd">first name:</label>
                    <input type="text" class="form-control" placeholder="Enter password" id="user_first_name"
                        name=first_name>
                </div>
                <div class="form-group">
                    <label for="pwd">last name:</label>
                    <input type="text " class="form-control" placeholder="Enter password" id="user_last_name"
                        name="last_name">
                </div>
                <input id='id' name="user_id" value="" hidden>
                <button type="submit" class="btn btn-primary" id=Submit>Submit</button>
            </div>
        </div>
        <br>
        <div id=candidates_data hidden>${candidates_data}</div>
        <div id=Userdata hidden>${UserService}</div>
        <div class="row">
            <div class="col-sm-6">
                <table id="tbl1" class="table">
                    <thead>
                        <tr>
                            <th>First Name </th>
                            <th>Last Name </th>
                            <th>Email</th>
                            <th>Action</th>
                            <th>Action</th>
                        </tr>
                    <tbody>

                    </tbody>
                    </thead>
                </table>
            </div>
            <div class="col-sm-6">
                <table id="tbl2" class="table">
                    <thead>
                        <tr>
                            <th>First Name </th>
                            <th>Last Name </th>
                            <th>Email</th>
                            <th>Action</th>
                            <th>Action</th>
                        </tr>
                    <tbody>

                    </tbody>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</body>

</html>