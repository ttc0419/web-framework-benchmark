package icu.ttc.wbm.controller;

import icu.ttc.wbm.model.Genre;
import icu.ttc.wbm.model.Record;
import icu.ttc.wbm.repository.GenreRepository;
import icu.ttc.wbm.repository.RecordRepository;
import icu.ttc.wbm.repository.RecordSpecification;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class RecordController {
    @Autowired
    GenreRepository genreRepository;

    @Autowired
    RecordRepository recordRepository;

    @GetMapping("/record")
    public String index(HttpServletRequest request, Model model,
                        @RequestParam(required = false) String name, @RequestParam(required = false) String artist,
                        @RequestParam(required = false) Integer year, @RequestParam(required = false) Integer genre) {
        List<Genre> genres = genreRepository.findAll();
        model.addAttribute("genres", genres);

        if (request.getQueryString() != null) {
            Specification<Record> spec = Specification.where(null);

            if (name != null && !name.isEmpty()) {
                spec = spec.and(RecordSpecification.nameLike(name));
            }

            if (artist != null && !artist.isEmpty()) {
                spec = spec.and(RecordSpecification.artistLike(name));
            }

            if (year != null) {
                spec = spec.and(RecordSpecification.yearBefore(year));
            }

            if (genre != null) {
                spec = spec.and(RecordSpecification.genreIs(genre));
            }

            List<Record> records = recordRepository.findAll(spec);
            model.addAttribute("records", records);
        }

        return "record";
    }
}
