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
    <link rel="stylesheet" type="text/css"  href="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.10.20/af-2.3.4/b-1.6.1/b-html5-1.6.1/b-print-1.6.1/fc-3.3.0/kt-2.5.1/r-2.2.3/rr-1.2.6/sc-2.0.1/sl-1.3.1/datatables.min.css" />
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
    <script type="text/javascript"src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.10.20/af-2.3.4/b-1.6.1/b-html5-1.6.1/b-print-1.6.1/fc-3.3.0/kt-2.5.1/r-2.2.3/rr-1.2.6/sc-2.0.1/sl-1.3.1/datatables.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <Style>
        /* Make the image fully responsive */
        .carousel-inner img {
            width: 100%;
            height: 100%;
        }
    </Style>
    <script>
        (function () {
            'use strict';
            window.addEventListener('load', function () {
                // Get the forms we want to add validation styles to
                var forms = document.getElementsByClassName('needs-validation');
                // Loop over them and prevent submission
                var validation = Array.prototype.filter.call(forms, function (form) {
                    form.addEventListener('submit', function (event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
        var registerd = [];
        $(document).ready(function () {
            $('.back').hide();
            $.each(JSON.parse($('#registerd').text()), function (i, ob) {
                registerd.push([
                    ob.name,
                    ob.gender,
                    ob.department,
                    ob.dob,
                    '<a class="btn btn-warning" href = "${pageContext.request.contextPath}/employee/${e.id}"><i class="fa fa-edit" style="font-size:24px"></i></a>',
                    '<a class="btn btn-warning" href = "${pageContext.request.contextPath}/delete/${e.id}"><i class="fa fa-trash" style="font-size:24px"></i></a>',
                ]);
            })
            $('#recordTbl').DataTable({
                data: registerd,
                "autoWidth": false,
                deferRender: true,
                pageLength: 10,
                "bLengthChange": false,
                info: false,
                scrollCollapse: true,
                responsive: true
            });
            $("#Aregister").on("click", function () {
                $('.back').show();
                $('.front').hide();
            });
            $("#Alogin").on("click", function () {
                $('.front').show();
                $('.back').hide();
            });
            $("#Rsubmit").on("click", function () {
                var postParameters = {
                    uid: $("#uid").val(),
                    uname: $("#uname").val(),
                    uSalary: $("#uSalary").val(),
                    uage: $("#uage").val(),
                    ucompany: $("#ucompany").val(),
                    pwd: $("#pwd").val(),
                }
                $.ajax({
                    url: "${pageContext.request.contextPath}/SaveRegister",
                    data: JSON.stringify(postParameters),
                    method: "post",
                    dataType: "json",
                    contentType: "application/json",
                    success: function (resp) { }
                });
            })
        })
    </script>
</head>

<body>
    <nav class="navbar navbar-expand-md bg-dark navbar-dark">
        <a class="navbar-brand" href="#">Book Store</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="collapsibleNavbar">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Books</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">About us</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Contacts</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="modal" data-target="#myModal">Sign in</a>
                </li>
            </ul>
        </div>
    </nav>
    <br>
    <div id=registerd hidden>${list}</div>
    <div id="demo" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ul class="carousel-indicators">
            <li data-target="#demo" data-slide-to="0" class="active"></li>
            <li data-target="#demo" data-slide-to="1"></li>
            <li data-target="#demo" data-slide-to="2"></li>
        </ul>
        <div class="container">
            <!-- The slideshow /SpringBoot_Hibernate/src/main/resources/static/images/imag1.jpg-->
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="/images/imag1.jpg " alt="Los Angeles" width="1100" height="500">
                </div>
                <div class="carousel-item">
                    <img src="/images/imag2.jpeg" alt="Chicago" width="1100" height="500">
                </div>
                <div class="carousel-item">
                    <img src="/images/imag4.jpg" alt="New York" width="1100" height="500">
                </div>
            </div>

            <!-- Left and right controls -->
            <a class="carousel-control-prev" href="#demo" data-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </a>
            <a class="carousel-control-next" href="#demo" data-slide="next">
                <span class="carousel-control-next-icon"></span>
            </a>
        </div>
    </div>
    <div class="container">
        <div class="col-sm-12">
            <table class="table table-hover" id="recordTbl">
                <caption>Your todos are</caption>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Gender</th>
                        <th>Department</th>
                        <th>Date of Birth</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <!-- The Modal -->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Login</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <div class="front">
                        <form id=login class="needs-validation" novalidate>
                            <input type="hidden" class="form-control" id="uid">
                            <div class="form-group">
                                <label for="uname">Username:</label>
                                <input type="text" class="form-control" id="uname" placeholder="Enter username"
                                    name="uname" required>
                                <div class="valid-feedback">Valid.</div>
                                <div class="invalid-feedback">Please fill out this field.</div>
                            </div>
                            <div class="form-group">
                                <label for="pwd">Password:</label>
                                <input type="password" class="form-control" id="pwd" placeholder="Enter password"
                                    name="pswd" required>
                                <div class="valid-feedback">Valid.</div>
                                <div class="invalid-feedback">Please fill out this field.</div>
                            </div>
                            <button type="submit" class="btn btn-primary" id=Lsubmit>Submit</button>
                            <a id=Aregister>Register here..</a>
                        </form>
                    </div>

                    <div class="back">
                        <form id="register" class="needs-validation" modelAttribute="employee"
                            action="${pageContext.request.contextPath}/save" novalidate>
                            <div class="form-group">
                                <hidden name="id" />
                                <label for="uname">Username:</label>
                                <input type="text" class="form-control" id="uname" placeholder="Enter username"
                                    name="name" required>
                                <div class="valid-feedback">Valid.</div>
                                <div class="invalid-feedback">Please fill out this field.</div>
                            </div>
                            <div class="form-group">
                                <label for="uage">Date of Birth:</label>
                                <input type="date" class="form-control" id="dob" placeholder="Enter Date of Birth"
                                    name="dob" required>
                                <div class="valid-feedback">Valid.</div>
                                <div class="invalid-feedback">Please fill out this field.</div>
                            </div>
                            <div class="form-group">
                                <label for="uSalary">Departement:</label>
                                <select name="department" class="form-control" required>
                                    <option value="Support">Support</option>
                                    <option value="Testing">Testing</option>
                                    <option value="Development">Development</option>
                                    <option value="Business Analyst">Business Analyst</option>
                                </select>
                                <div class="valid-feedback">Valid.</div>
                                <div class="invalid-feedback">Please fill out this field.</div>
                            </div>
                            <div class="form-group">
                                <label for="uCompany">Gender:</label>
                                <div class="radio">
                                    <input type="radio" name="gender" value="Male" />Male&nbsp;
                                    <input type="radio" name="gender" value="Female" />Female</div>

                                <div class="valid-feedback">Valid.</div>
                                <div class="invalid-feedback">Please fill out this field.</div>
                            </div>
                            <div class="form-group">
                                <label for="pwd">Password:</label>
                                <input type="password" class="form-control" id="pswd" placeholder="Enter password"
                                    name="pswd" required>
                                <div class="valid-feedback">Valid.</div>
                                <div class="invalid-feedback">Please fill out this field.</div>
                            </div>
                            <button type="submit" class="btn btn-primary" id=Rsubmit>Submit</button>
                            <a id=Alogin>Back to Login</a>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
</body>

</html>