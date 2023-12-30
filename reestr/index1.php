<?php

require_once 'Dog.php';
require_once 'Cat.php';
require_once 'Hamster.php';

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();

if (!isset($_SESSION['animalsList'])) {
    $_SESSION['animalsList'] = [];
}

if (isset($_POST['name'], $_POST['birthDate'], $_POST['animalType'])) {
    $name = $_POST['name'];
    $birthDate = $_POST['birthDate'];
    $animalType = $_POST['animalType'];

    switch ($animalType) {
        case 'Dog':
            $animal = new Dog($name, $birthDate);
            break;
        case 'Cat':
            $animal = new Cat($name, $birthDate);
            break;
        case 'Hamster':
            $animal = new Hamster($name, $birthDate);
            break;
        default:
            $animal = null; 
    }

    if ($animal) {
        $_SESSION['animalsList'][] = $animal;
        echo "Животное успешно добавлено в список!";
    }
}


if (isset($_POST['listAnimals'])) {
    $animalType = $_POST['animalType'];

    $filteredAnimals = array_filter($_SESSION['animalsList'], function ($animal) use ($animalType) {
        return get_class($animal) === $animalType;
    });

    echo "<h2>Список животных типа: " . $animalType . "</h2>";
    foreach ($filteredAnimals as $animal) {
        echo "Имя: " . $animal->getName() . "<br>";
        echo "Дата рождения: " . $animal->getBirthDate() . "<br>";
        echo "Тип: " . get_class($animal) . "<br><br>";
    }
}

function findAnimalByName($name, $animals) {
    foreach ($animals as $animal) {
        if ($animal->getName() === $name) {
            return $animal;
        }
    }
    return null;
}

function handleListCommands($animalName, $animalsList) {
    $animal = findAnimalByName($animalName, $animalsList);
    
    if ($animal !== null) {
        echo "Список команд для животного: " . htmlspecialchars($animal->getName());
        echo "<ul>";
        foreach ($animal->getCommands() as $command) {
            echo "<li>" . htmlspecialchars($command) . "</li>";
        }
        echo "</ul>";
    } else {
        echo "Животное с именем '" . htmlspecialchars($animalName) . "' не найдено.";
    }
}

function handleTrainAnimal($animalName, $command, $animalsList) {
    $animal = findAnimalByName($animalName, $animalsList);
    
    if ($animal !== null) {
        $animal->learnNewCommand($command);
        echo "Животное '" . htmlspecialchars($animal->getName()) . "' научилось новой команде: " . htmlspecialchars($command);
    } else {
        echo "Животное с именем '" . htmlspecialchars($animalName) . "' не найдено.";
    }
}

if (isset($_POST['listCommands'])) {
    $animalName = $_POST['animalName'];
    handleListCommands($animalName, $_SESSION['animalsList']);
}

if (isset($_POST['trainAnimal'])) {
    $animalName = $_POST['animalName'];
    $command = $_POST['newCommand'];
    handleTrainAnimal($animalName, $command, $_SESSION['animalsList']);
}
?>








