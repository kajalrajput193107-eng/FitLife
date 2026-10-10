package com.fitlife.model;

public class DietPlan {

    private int id;
    private String planName;
    private String goal;
    private String mealType;
    private String foodItems;
    private int calories;
    private String dietType;

    public DietPlan(int id, String planName, String goal,
                    String mealType, String foodItems,
                    int calories, String dietType) {

        this.id = id;
        this.planName = planName;
        this.goal = goal;
        this.mealType = mealType;
        this.foodItems = foodItems;
        this.calories = calories;
        this.dietType = dietType;
    }

    public int getId() {
        return id;
    }

    public String getPlanName() {
        return planName;
    }

    public String getGoal() {
        return goal;
    }

    public String getMealType() {
        return mealType;
    }

    public String getFoodItems() {
        return foodItems;
    }

    public int getCalories() {
        return calories;
    }

    public String getDietType() {
        return dietType;
    }
}