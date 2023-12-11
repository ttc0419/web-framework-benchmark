<?php

namespace App\Http\Controllers;

use App\Models\Genre;
use App\Models\Record;
use Illuminate\Http\Request;

class RecordController extends Controller
{
	public function index(Request $request)
	{
		$viewParams = ['genres' => Genre::all()];
		$queryParams = $request->query->all();

		if (!empty($queryParams)) {
			$request->validate([
				'year' => 'integer|nullable',
				'genre' => 'integer|nullable'
			]);

			$query = Record::with('genre');

			if (!empty($queryParams['name']))
				$query = $query->where('name', 'LIKE', "%{$queryParams['name']}%");

			if (!empty($queryParams['artist']))
				$query = $query->where('artist', 'LIKE', "%{$queryParams['artist']}%");

			if (!empty($queryParams['year']))
				$query = $query->where('year', '<=', $queryParams['year']);

			if (!empty($queryParams['genre']))
				$query = $query->where('genre_id', '=', $queryParams['genre']);

			$viewParams['records'] = $query->get();
		}

		return view('record.index')->with($viewParams);
	}

	public function create()
	{
	}

	public function store(Request $request)
	{
	}

	public function show(Record $record)
	{
	}

	public function edit(Record $record)
	{
	}

	public function update(Request $request, Record $record)
	{
	}

	public function destroy(Record $record)
	{
		fwrite(fopen('php://stdout', 'w'), "Deleting record $record->id...\n");
		return redirect(route('record.index'));
	}
}
