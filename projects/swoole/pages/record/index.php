<?php
/**
 * @var PDO $pdo
 * @var string $csrf
 * @var Swoole\Http\Request $request
 * @var Swoole\Http\Response $response
 */

if ($request->server['request_method'] !== 'GET') {
    $response->setStatusCode(405);
    return;
}

require 'libs/mysql.php';

$genres = $pdo->query("SELECT * FROM `genres`");

if (!empty($request->get)) {
	if ((!empty($request->get['year']) && !ctype_digit($request->get['year']))
			|| (!empty($request->get['genre']) && !ctype_digit($request->get['genre']))) {
		$response->setStatusCode(400);
		return;
	}

    require 'libs/get-csrf.php';

    $sqlParams = [];
    $sql = "SELECT `records`.*, `genres`.`name` AS `genre_name` FROM records INNER JOIN genres ON records.genre_id = genres.id WHERE 1=1";

    if (!empty($request->get['name'])) {
        $sql .= " AND records.name LIKE ?";
        $sqlParams[] = "%{$request->get['name']}%";
    }

    if (!empty($request->get['artist'])) {
        $sql .= " AND records.artist LIKE ?";
        $sqlParams[] = "%{$request->get['artist']}%";
    }

    if (!empty($request->get['year'])) {
        $sql .= " AND records.name <= ?";
        $sqlParams[] = $request->get['year'];
    }

    if (!empty($request->get['genre'])) {
        $sql .= " AND records.genre_id = ?";
        $sqlParams[] = $request->get['genre'];
    }

	$records = $pdo->prepare($sql);
	$records->execute($sqlParams);
}

$response->header('Content-Type', 'text/html; charset=utf-8');

ob_start();
readfile('pages/layouts/main-top.html');
?>

<div class="card card-body">
    <h3>Search</h3>
    <form action="/record/index.php">
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
                        <?php while ($genre = $genres->fetch()): ?>
                            <option value="<?= $genre['id'] ?>"><?= $genre['name'] ?></option>
                        <?php endwhile; ?>
                    </select>
                </div>
            </div>
        </fieldset>
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <?php if (isset($records)): ?>
        <br><br>

        <div class="d-flex flex-row justify-content-between mb-2">
            <h3>Results</h3>
            <a href="/record/create.php" class="btn btn-primary">New Record</a>
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
                    <th class="actions">Actions</th>
                </tr>
                </thead>

                <tbody>
                <?php if ($records->rowCount() === 0): ?>
                    <tr>
                        <td colspan="6" class="text-center">No matched records found</td>
                    </tr>
                <?php else: ?>
                    <form action="/record/delete.php" method="post" id="deletion-form" class="d-none">
                        <input type="hidden" name="csrf" value="<?= $csrf ?>">
                    </form>
                    <?php while ($record = $records->fetch()): ?>
                        <tr>
                            <td><?= $record['name'] ?></td>
                            <td>
                                <?php if (!empty($record['genre_name'])): ?>
                                    <a href="/genre/show?id=<?= $record['genre_id'] ?>"><?= $record['genre_name'] ?></a>
                                <?php else: ?>
                                    N/A
                                <?php endif; ?>
                            </td>
                            <td><?= $record['artist'] ?></td>
                            <td><?= $record['year'] ?></td>
                            <td><?= $record['number_of_discs'] ?></td>
                            <td class="actions">
                                <a href="/record/edit.php?id=<?= $record['id'] ?>" class="btn btn-sm btn-primary border-0 d-inline-block text-decoration-none">Edit</a>
                                <button type="submit" form="deletion-form" name="id" value="<?= $record['id'] ?>"
                                        class="btn btn-sm btn-danger border-0 d-inline-block">Delete
                                </button>
                            </td>
                        </tr>
                    <?php endwhile; ?>
                    <script src="/js/confirm-deletion.js"></script>
                <?php endif; ?>
                </tbody>
            </table>
        </div>
    <?php endif; ?>
</div>

<?php
readfile('pages/layouts/main-bottom.html');
$response->end(ob_get_clean());
?>
