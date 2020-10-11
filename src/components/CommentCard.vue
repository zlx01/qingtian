<template>
  <div class="grid-item">
    <div class="userinfo">
      <img :src="commentObj.user.avatarUrl" alt="avatar" class="avatar">
    </div>
    <div class="content">
      <span>{{commentObj.content}}</span>
      <div class="nickname">- {{commentObj.user.nickname}}</div>
      <div class="time">{{this.dateFormat(commentObj.time)}}</div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CommentCard',
  props: {
    commentObj: {
      commentId: String,
      user: {
        avatarUrl: String,
        nickname: String,
      },
      content: String,
      time: undefined
    }
  },
  methods: {
    dateFormat(timestamp, formats) {
      formats = formats || "Y-m-d";

      const zero = (value) => {
        if (value < 10) {
          return "0" + value;
        }
        return value;
      };

      const myDate = timestamp ? new Date(timestamp) : new Date();

      const year = myDate.getFullYear();
      const month = zero(myDate.getMonth() + 1);
      const day = zero(myDate.getDate());

      const hour = zero(myDate.getHours());
      const minite = zero(myDate.getMinutes());
      const second = zero(myDate.getSeconds());

      return formats.replace(/Y|m|d|H|i|s/gi, function (matches) {
        return {
          Y: year,
          m: month,
          d: day,
          H: hour,
          i: minite,
          s: second,
        }[matches];
      });
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .grid-item {
    background-color: #fff;
    cursor: pointer;
    width: 300px;
    border-radius: 4px;
    padding: 20px 20px 20px 10px;
    margin-bottom: 16px;
    overflow: auto;
    box-shadow: 0px 2px 1px -1px rgba(0, 0, 0, 0.2),
    0px 1px 1px 0px rgba(0, 0, 0, 0.14), 0px 1px 3px 0px rgba(0, 0, 0, 0.12);
    vertical-align: middle;
  }

  .grid-item .avatar {
    width: 60px;
    height: 60px;
    background-color: #eee;
    display: block;
    border-radius: 50%;
    border: 2px solid #fff;
  }
  .grid-item .userinfo {
    float: left;
    height: 100%;
  }
  .grid-item .content {
    color: #333;
    padding-left: 80px;
    /* text-indent: 2em; */
  }
  .grid-item .nickname {
    color: #999;
    font-size: 13px;
    text-align: right;
    padding-top: 6px;
  }

  .grid-item .time {
    color: #aaa;
    font-size: 12px;
    text-align: right;
    padding-top: 2px;
  }
</style>
