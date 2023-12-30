<?php
require_once 'Animal.php';

class Cat extends Animal {
    private $commands = [];

    public function getName() {
        return $this->name; 
    }
    
    public function getBirthDate() {
        return $this->birthDate;
    }

    public function learnNewCommand($command) {
        $this->commands[] = $command;
    }
    public function __construct($name, $birthDate) {
        parent::__construct($name, $birthDate);
        
    }
    public function addCommand($command) {
        
        $this->trainingCommands[] = $command;
    }
    public function getCommands() {
        return $this->commands;
    }
    

}
