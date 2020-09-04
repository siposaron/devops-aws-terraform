
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Sample form with lambda call">
    <meta name="author" content="Aron">

    <title>Terraform created Lambda caller</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  </head>

  <body class="text-center">
    <div class="container">
        <div class="row">
          <div class="col-sm"></div>
          <div class="col-sm">
            <form>
                <div class="form-group">
                  <h1 class="h3 mb-3 font-weight-normal">Greetings from AWS Lambda</h1>
                  <label for="nameId" class="sr-only">Name</label>
                  <input type="text" id="nameId" class="form-control" placeholder="Your name" required autofocus>
                  <button class="btn btn-lg btn-primary btn-block" type="button" onclick="return greet()">Send</button>
                  <div>&nbsp;</div>
                  <div id="responsePlaceHolder">&nbsp;</div>
                  <p class="mt-5 mb-3 text-muted">&copy; 2020</p>
                </div>
              </form>
          </div>
          <div class="col-sm"></div>
        </div>
      </div>
  </body>

    <script>
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                console.log(this.response);
                document.getElementById("responsePlaceHolder").innerHTML = this.response.replace(/"/gi, '');
            }
        }

        function greet() {    
            const name = document.getElementById("nameId").value;
            xhr.open("POST", "##lambda-url##", true);
            xhr.setRequestHeader('Content-Type', 'text/plain');
            xhr.send(JSON.stringify(name));
        }
    </script>
</html>