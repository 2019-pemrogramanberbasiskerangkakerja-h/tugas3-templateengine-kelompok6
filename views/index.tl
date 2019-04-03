<!doctype html>
<html>
<head>
    <title>${d.head}</title>
</head>
<body>
   	
   	<name>
        ${'Nama = ' + d.name}
        <br>
    </name>

    <email>
    	${d.email ? 'Email ='+ d.email : ''}
        <br>
    </email>

    <password>
    	${d.password ? 'Password =' + d.password : ''}
        <br>
    </password>

    <dessert>
    </dessert>
</body>
</html>