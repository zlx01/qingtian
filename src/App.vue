<template>
  <div id="app">
    <h1 class="title">- 晴天の网易云评论 -</h1>
    <div style="text-align: center;">
<!--          src="//player.bilibili.com/player.html?aid=328746951&bvid=BV1VA411e7PM&cid=208118542&page=1"-->
      <iframe
          src="//player.bilibili.com/player.html?bvid=BV1d4411N7zD"
          scrolling="no"
          border="0"
          frameborder="no"
          framespacing="0"
          allowfullscreen
          style="width: 800px; height: 500px;"
      />
    </div>
    <h2 class="subtitle">热评 TOP15</h2>
    <div id="hot-comment-list">
      <CommentCard
          v-for="(item,index) in hotCommentList"
          :key="index"
          :comment-obj="item"/>
    </div>

    <h2 class="subtitle">评论回忆</h2>
    <div id="comment-list">
      <CommentCard
          v-for="(item,index) in commentList"
          :key="index"
          :comment-obj="item"/>
    </div>
    <div class="load-more">
      <a class="load-more-button" @click="loadMoreComments">
        {{loading ? "..." : "加载更多"}}
      </a>
    </div>
  </div>
</template>

<script>
import CommentCard from './components/CommentCard.vue'
import Axios from "axios"
import Bricks from "bricks.js"

export default {
  name: 'App',
  components: {
    CommentCard
  },
  data() {
    return {
      page: 1,
      hotCommentList: [],
      commentList: [],
      hotCommentInst: undefined,
      commentInst: undefined,
      loading: false
    }
  },
  mounted() {
    // 必须在mounted而不是created时实例化Bricks，
    // 否则document.querySelector("#xxx")获取不到container
    this.initBricks();
    this.loadHotComments();
    this.loadMoreComments();
  },
  methods: {
    initBricks() {
      let sizeOpt = [
        { columns: 2, gutter: 10 },
        { mq: "600px", columns: 3, gutter: 10 },
        { mq: "800px", columns: 4, gutter: 10 },
        { mq: "1000px", columns: 5, gutter: 16 },
        { mq: "1130px", columns: 5, gutter: 16 },
      ];
      this.hotCommentInst = Bricks({
        container: "#hot-comment-list",
        packed: "data-packed",
        sizes: sizeOpt,
      })
      this.commentInst = Bricks({
        container: "#comment-list",
        packed: "data-packed",
        sizes: sizeOpt,
      });
    },
    getData(limit = 50, offset) {
      return Axios.get("https://musicapi.leanapp.cn/comment/music", {
        withCredentials: true,
        params: {
          id: 186016,
          limit,
          offset, // 倒序
        },
      }).then((res) => res.data);
    },
    loadHotComments() {
      this.getData(20).then((data) => {
        this.hotCommentList = data.hotComments;
        // 必须用$nextTrick，否则pack不生效
        this.$nextTick(() => {
          this.hotCommentInst.pack()
        })
      });
    },
    loadMoreComments() {
      if (this.loading) return;
      this.loading = true;
      this.getData(50, 2027450 - this.page * 50).then((data) => {
        this.commentList = this.commentList.concat(data.comments);
        // 必须用$nextTrick，否则pack不生效
        this.$nextTick(() => {
          this.commentInst.pack()
          this.page === 1 ? this.commentInst.pack() : this.commentInst.update();
        })
        this.page++;
      }).finally(() => {
        this.loading = false;
      });
    }
  }
}
</script>

<style>
body {
  background-color: #cd353b;
  font-family: -apple-system,BlinkMacSystemFont,"Segoe UI","Roboto","Oxygen","Ubuntu","Cantarell","Fira Sans","Droid Sans","Helvetica Neue",sans-serif;
}

#app {
  padding: 20px;
}

.title {
  color: #fff;
  text-align: center;
  margin-bottom: 30px;
}

.subtitle {
  border-left: 6px solid #fff;
  padding-left: 10px;
  color: #eee;
}

#hot-comment-list {
  margin-bottom: 40px;
}

.load-more {
  margin-top: 30px;
  text-align: center;
}

.load-more .load-more-button {
  cursor: pointer;
  background-color: #fff;
  border-radius: 4px;
  width: 100px;
  padding: 10px;
  display: inline-block;
  color: #cd353b;
}

.load-more-button:hover {
  background-color: #cd353b;
  color: #fff;
  border: 1px solid #fff;
}

</style>
