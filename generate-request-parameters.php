<?php
declare(strict_types = 1);

const DIR_NAME = "parameters";

if (file_exists(DIR_NAME)) {
    echo 'The file/directory called "parameters" exists.  Please delete it first ' . PHP_EOL;
    exit(1);
}

mkdir(DIR_NAME);

for ($i = 0; $i < 16384; ++$i) {
    $mode = rand(0, 4);
    switch ($mode) {
        /* name */
        case 0:
            $name = "";
            $length = rand(1, 2);
            for ($j = 0; $j < $length; ++$j)
                $name .= chr(rand(0, 25) + 65);
            $query = "?name=$name&artist=&year=&genre=";
            break;
        /* artist */
        case 1:
            $artist = "";
            $length = rand(1, 2);
            for ($j = 0; $j < $length; ++$j)
                $artist .= chr(rand(0, 25) + 65);
            $query = "?name=&artist=$artist&year=&genre=";
            break;
        /* year */
        case 2:
            $year = rand(1990, 1999);
            $query = "?name=&artist=&year=$year&genre=";
            break;
        /* genre */
        case 3:
            $genre = rand(1, 9);
            $query = "?name=&artist=&year=&genre=$genre";
            break;
        /* name & genre */
        case 4:
            $name = "";
            $length = rand(1, 2);
            for ($j = 0; $j < $length; ++$j)
                $name .= chr(rand(0, 25) + 65);
            $genre = rand(1, 9);
            $query = "?name=$name&artist=&year=&genre=$genre";
            break;
    }
    file_put_contents(DIR_NAME . DIRECTORY_SEPARATOR . $i, $query);
}

file_put_contents(DIR_NAME . DIRECTORY_SEPARATOR . 'index', '0');
