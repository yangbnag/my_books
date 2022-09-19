package com.ibini.my_books.post.service;

import com.ibini.my_books.common.search.SearchPost;
import com.ibini.my_books.hashtag.service.HashTagService;
import com.ibini.my_books.post.domain.Post;
import com.ibini.my_books.post.dto.PostWithName;
import com.ibini.my_books.post.repository.PostMapper;
import com.ibini.my_books.postImg.service.PostImgService;
import com.ibini.my_books.postnote.service.PostMarkService;
import com.ibini.my_books.postnote.service.PostMemoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Log4j2
@RequiredArgsConstructor
public class PostService {

    private final PostMapper postMapper;
    private final HashTagService tagService;
    private final PostImgService imgService;
    private final LinkPostService linkPostService;
    private final PostMarkService postMarkService;
    private final PostMemoService postMemoService;


    //    포스트 등록
    public boolean saveService(Post post) {
        log.info("Post Service : saveService call - {}", post);
        return postMapper.save(post);
    }

    //    계정별 포스트 전체 조회
    public List<Post> findAllPostService(String account) {
        log.info("Post Service : findAllService call");
        return postMapper.findAllPost(account);
    }

    //    계정별 포스트dto 전체 조회
    public List<PostWithName> finaAllPostWithNameService(String account) {
        log.info("Post Service : finaAllPostWithNameService call");

        List<PostWithName> postWithNameList = postMapper.findAllPostWithName(account);
        int size = postWithNameList.size();
        for (PostWithName postWithName : postWithNameList) {
            postWithName.setting();
            postWithName.setOneLineTag(tagService.mergeTag(postWithName.getPostNo()));
        }
        return postWithNameList;
    }

    //    포스트 개별 조회
    public Post findOnePostService(Long postNo) {
        log.info("Post Service : findOnePostService call");
        return postMapper.findOnePost(postNo);
    }

    //    포스트 dto 개별 조회
    public PostWithName fineOnePostWithName(Long postNo) {
        log.debug("Post Service : fineOnePostWithName call");
        PostWithName p = postMapper.fineOnePostWithName(postNo);
        p.setting();
        p.setOneLineTag(tagService.mergeTag(postNo));
        log.info("findOnePostWitheName - {}", p);
        return p;
    }

    //    포스트 삭제
    public boolean removeService(Long postNo) {
        log.info("Post Service : removeService call - {}", postNo);

//        포스트 삭제 전 해시태그, 이미지, 링크포스트, 마크, 메모 전부 지우기
        tagService.removeTagOnPost(postNo);
        imgService.removeByPostNo(postNo);
        linkPostService.postDeleteService(postNo);
        postMarkService.removeAll(postNo);
        postMemoService.removeAll(postNo);

        return postMapper.remove(postNo);
    }

    //    수정
    public boolean modifyService(Post post) {
        log.info("Post Service : modifyService call - {}", post);
        return postMapper.modify(post);
    }

    //    계정별 포스트 수 전체 조회
    public int getTotalCount(String account) {
        log.info("Post Service : getTotalCountService call");
        return postMapper.getTotalCount(account);
    }

    // 검색이 적용된 전체 포스트
    public Map<String, Object> searchAllPostWithNameService(SearchPost searchPost) {
        log.info("Post Service :searchAllPostWithName call - {}", searchPost);

        HashMap<String, Object> searchMap = new HashMap<>();

        List<PostWithName> postList = postMapper.searchAllPostWithName(searchPost);
        for (PostWithName p : postList) {
            p.setOneLineTag(tagService.mergeTag(p.getPostNo()));
            p.setting();
        }
        searchMap.put("pl", postList);
        searchMap.put("tc", postMapper.getTotalCountWithSearch(searchPost));

        return searchMap;
    }

    // 특정 장르 아이디를 가진 포스트의 post_no 모두 조회
    public List<Post> getPostByGenreId(int genreId) {
        log.info("PostService getPostByGenreId Call - {}", genreId);
        return postMapper.getPostByGenreId(genreId);
    }
    public int getPostByGenreIdTotal(int genreId, String account){
        log.info("PostService getPostByGenreIdTotal - {} -{}", genreId, account);
        return postMapper.getPostByGenreIdTotal(genreId, account);
    }

    // 특정 플랫폼 아이디를 가진 포스트의 post_no 모두 조회
    public List<Post> getPostByPlateId(int platformId) {
        log.info("PostService getPostByPlateId Call - {}", platformId);
        return postMapper.getPostByPlateId(platformId);
    }

    // platform 숫자조회
    public int getPostByPlateIdUseplat(int platformId, String account){
        log.info("PostService getPostByPlateIdUseplat Call - {} -{}" , platformId, account);
        return postMapper.getPostByPlateIdUseplat(platformId, account);
    }

    /**
     * 계정과 이메일의 중복을 확인하는 메서드
     *
     * @param type  - 확인할 정보 (ex: title)
     * @param value - 확인할 값
     * @param postNo - 등록 페이지에서는 0, 수정 페이지에서는 포스트 번호가 넘어와 중복 검사에서 제외시킨다
     * @return 중복이라면 true, 중복이 아니라면 false
     */
    public boolean checkSignUpValue(String type, String value, Long postNo, String account) {
        Map<String, Object> checkMap = new HashMap<>();
        checkMap.put("type", type);
        checkMap.put("value", value);
        checkMap.put("postNo", postNo);
        checkMap.put("account", account);

        return postMapper.isDuplicate(checkMap) == 1;
    }

    public boolean regFavoriteService(Long postNo, String account){
        log.info("regFavoriteService call - {} / {}", postNo, account);
        return postMapper.regFavorite(postNo, account);
    }

    public boolean removeFavoriteService(Long postNo){
        log.info("removeFavoriteService call - {}", postNo);
        return postMapper.resetFavorite(postNo);
    }


}
