<?php
/**
 * @var \App\Models\Genre[] $genres
 * @var \App\Models\Record[] $records
 */
?>

@extends('layouts.main')

@section('content')
    <div class="card card-body">
        <h3>Search</h3>
        <form action="{{ route('record.index') }}">
            <fieldset>
                <label for="name">Name</label>
                <input type="text" name="name" id="name" class="form-control mb-2">
                <div class="row">
                    <div class="col-12 col-sm-4">
                        <label for="artist">Artist</label>
                        <input type="text" name="artist" id="artist" class="form-control mb-2">
                    </div>
                    <div class="col-12 col-sm-4">
                        <label for="year">Year (No later than)</label>
                        <input type="number" name="year" id="year" class="form-control mb-2">
                    </div>
                    <div class="col-12 col-sm-4">
                        <label for="genre">Genre</label>
                        <select name="genre" id="genre" class="form-select mb-4">
                            <option value selected>-- Don't filter by genre --</option>
                            @foreach($genres as $genre)
                                <option value="{{ $genre->id }}">{{ $genre->name }}</option>
                            @endforeach
                        </select>
                    </div>
                </div>
            </fieldset>
            <button type="submit" class="btn btn-primary">Search</button>
        </form>

        @isset($records)
            <br><br>

            <div class="d-flex flex-row justify-content-between mb-2">
                <h3>Results</h3>
                <a href="{{ route('record.create') }}" class="btn btn-primary">New Record</a>
            </div>

            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Genre</th>
                        <th>Artist</th>
                        <th>Year</th>
                        <th>Number of Discs</th>
                        <th>Actions</th>
                    </tr>
                    </thead>

                    <tbody>
                    @if (count($records) === 0)
                        <tr>
                            <td colspan="6" class="text-center">No matched records found</td>
                        </tr>
                    @else
                        <form action="{{ route('record.destroy', 0) }}" method="post" id="deletion-form" class="d-none">@method('DELETE')@csrf</form>
                        @foreach ($records as $record)
                            <tr>
                                <td>{{ $record->name }}</td>
                                <td>
                                    @if (!empty($record->genre))
                                        <a href="{{ route('genre.show', [$record->genre->id]) }}">{{ $record->genre->name }}</a>
                                    @else
                                        N/A
                                    @endif
                                </td>
                                <td>{{ $record->artist }}</td>
                                <td>{{ $record->year }}</td>
                                <td>{{ $record->number_of_discs }}</td>
                                <td>
                                    <a href="{{ route('record.edit', $record->id) }}" class="btn-sm btn-primary d-inline-block text-decoration-none">Edit</a>
                                    <button type="submit" form="deletion-form" data-record-id="{{ $record->id }}"
                                            class="btn-sm btn-danger d-inline-block border-0">Delete</button>
                                </td>
                            </tr>
                        @endforeach
                        <script src="{{ asset('js/confirm-deletion.js') }}"></script>
                    @endif
                    </tbody>
                </table>
            </div>
        @endisset
    </div>
@endsection
