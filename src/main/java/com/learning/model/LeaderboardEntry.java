package com.learning.model;
public class LeaderboardEntry {
    private Long id;
    private String name;
    private String section;
    private Integer totalQuizzes;
    private Integer totalScore;
    private Double avgScore;
    private Integer rank;
    private Boolean isCurrentUser;
    public LeaderboardEntry() {}
    public LeaderboardEntry(Long id, String name, String section, Integer totalQuizzes, Integer totalScore, Double avgScore) {
        this.id = id;
        this.name = name;
        this.section = section;
        this.totalQuizzes = totalQuizzes;
        this.totalScore = totalScore;
        this.avgScore = avgScore;
    }
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getSection() { return section; }
    public void setSection(String section) { this.section = section; }
    public Integer getTotalQuizzes() { return totalQuizzes; }
    public void setTotalQuizzes(Integer totalQuizzes) { this.totalQuizzes = totalQuizzes; }
    public Integer getTotalScore() { return totalScore; }
    public void setTotalScore(Integer totalScore) { this.totalScore = totalScore; }
    public Double getAvgScore() { return avgScore; }
    public void setAvgScore(Double avgScore) { this.avgScore = avgScore; }
    public Integer getRank() { return rank; }
    public void setRank(Integer rank) { this.rank = rank; }
    public Boolean getIsCurrentUser() { return isCurrentUser; }
    public void setIsCurrentUser(Boolean isCurrentUser) { this.isCurrentUser = isCurrentUser; }
}
