<?php

namespace App\Http\Controllers;

use App\Models\Genre;
use Illuminate\Http\Request;

class GenreController extends Controller
{
	public function index()
	{
		return view('genre.index');
	}

	public function create()
	{
	}

	public function store(Request $request)
	{
	}

	public function show(Genre $genre)
	{
	}

	public function edit(Genre $genre)
	{
	}

	public function update(Request $request, Genre $genre)
	{
	}

	public function destroy(Genre $genre)
	{
	}
}
