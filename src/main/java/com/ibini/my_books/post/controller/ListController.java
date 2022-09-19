package com.ibini.my_books.post.controller;

import com.ibini.my_books.common.paging.Page;
import com.ibini.my_books.common.paging.PageMaker;
import com.ibini.my_books.common.search.SearchPost;
import com.ibini.my_books.genre.service.GenreService;
import com.ibini.my_books.hashtag.service.HashTagService;
import com.ibini.my_books.platform.service.PlatformService;
import com.ibini.my_books.post.dto.PostWithName;
import com.ibini.my_books.post.service.PostService;
import com.ibini.my_books.postImg.service.PostImgService;
import com.ibini.my_books.util.LoginUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/list")
public class ListController {
    private final PostImgService imgService;
    private final PostService postService;
    private final HashTagService hashTagService;
    private final GenreService genreService;
    private final PlatformService platformService;

//    포스트 전체 리스트 요청   get    /list

    @GetMapping()
    public String postList(SearchPost searchPost, Model model, HttpSession session) {
        // 사용자 계정 세팅
        String account = LoginUtil.getCurrentMemberAccountForDB(session);
        searchPost.setAccount(account);
        log.info("ListController /list  GET!! - {}", searchPost);

        Map<String, Object> postMap = postService.searchAllPostWithNameService(searchPost);
        log.info("postMap - {}", postMap);

        // 페이지 정보 생성
        PageMaker pm = new PageMaker(
                new Page(searchPost.getPageNum(), searchPost.getAmount())
                , (Integer) postMap.get("tc")
        );
        log.info("pm : {}", pm);

        model.addAttribute("pl", postMap.get("pl")); //  List<PostWithName>
        model.addAttribute("pm", pm);
        model.addAttribute("gl", genreService.findAllService(account));
        model.addAttribute("pfl", platformService.findAllPlatform(account));

        return "post/post-list";
    }


}
