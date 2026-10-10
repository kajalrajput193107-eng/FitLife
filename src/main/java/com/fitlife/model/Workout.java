package com.fitlife.model;

public class Workout {

    private int id;
    private String exerciseName;
    private String category;
    private int sets;
    private int repetitions;
    private String instructions;
    private String difficulty;
    private String goal;

    public Workout(int id, String exerciseName, String category,
                   int sets, int repetitions, String instructions,
                   String difficulty, String goal) {

        this.id = id;
        this.exerciseName = exerciseName;
        this.category = category;
        this.sets = sets;
        this.repetitions = repetitions;
        this.instructions = instructions;
        this.difficulty = difficulty;
        this.goal = goal;
    }

    public int getId() {
        return id;
    }

    public String getExerciseName() {
        return exerciseName;
    }

    public String getCategory() {
        return category;
    }

    public int getSets() {
        return sets;
    }

    public int getRepetitions() {
        return repetitions;
    }

    public String getInstructions() {
        return instructions;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public String getGoal() {
        return goal;
    }
}