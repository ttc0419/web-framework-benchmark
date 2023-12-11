package icu.ttc.wbm.model;

import jakarta.persistence.*;

@Entity
@Table(name = "records")
public class Record {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;

    @ManyToOne
    @JoinColumn(name = "genre_id")
    private Genre genre;

    private String artist;

    private Integer year;

    private Integer numberOfDiscs;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(Genre genre) {
        this.genre = genre;
    }

    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Integer getNumberOfDiscs() {
        return numberOfDiscs;
    }

    public void setNumberOfDiscs(Integer numberOfDiscs) {
        this.numberOfDiscs = numberOfDiscs;
    }
}
