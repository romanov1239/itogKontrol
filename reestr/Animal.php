<?php
class Animal {
    protected $name;
    protected $birthDate;
    protected $trainingCommands = [];

    public function __construct($name, $birthDate) {
        $this->name = $name;
        $this->birthDate = $birthDate;
    }
    
    public function getName() {
        return $this->name;
    }
    
    public function getBirthDate() {
        return $this->birthDate;
    }
    
}
?>