<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Antique Records</title>

    <link rel="stylesheet" href="{{ asset('css/bootstrap.min.css') }}">
    <script src="{{ asset('js/bootstrap.bundle.min.js') }}"></script>
</head>

<body class="d-flex flex-column justify-content-between yellow" style="min-height: 100vh; background-color: #fbf9f6">
<nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img src="{{ asset('img/brand.png') }}" alt="Brand Logo">
            Antique Records
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar"
                aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbar">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="{{ route('record.index') }}">Records</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="{{ route('genre.index') }}">Genres</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<main class="container">
    @yield('content')
</main>

<footer class="d-flex flex-wrap justify-content-between align-items-center py-3 mt-4 border-top bg-light">
    <p class="col-md-4 mb-0 ms-4 text-muted">© 2021 Antique Records, Inc</p>

    <img src="{{ asset('img/brand.png') }}" alt="Brand Logo">

    <ul class="nav col-md-4 justify-content-end">
        <li class="nav-item">
            <a href="{{ route('record.index') }}" class="nav-link px-2 text-muted">Records</a>
        </li>
        <li class="nav-item">
            <a href="{{ route('genre.index') }}" class="nav-link px-2 text-muted me-4">Genres</a>
        </li>
    </ul>
</footer>
</body>
</html>
