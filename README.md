# 《晴天》网易云评论

## 项目说明

* 本项目是将B站up主`objtube的卢克儿`的《晴天》网易云评论项目从React编写改成Vue编写

* 视频地址：https://www.bilibili.com/video/BV1vC4y1t7Wi

* 效果展示：https://objtube.gitee.io/qingtian/

* 项目地址：https://github.com/ObjTube/NeteaseMusic-qingtian-comment

* 《晴天》网易云播放页面链接：https://music.163.com/#/song?id=186016

## 技术要点

1. 用iframe展示b站晴天视频的h5播放页面。视频播放器连接：
```text
https://player.bilibili.com/player.html?bvid=BV号
https://player.bilibili.com/player.html?aid=AV号
```

2. 使用大佬提供的[网易云接口](https://github.com/Binaryify/NeteaseCloudMusicApi)获取评论信息

3. 使用[bricks.js](https://github.com/callmecavs/bricks.js)瀑布流插件展示评论

---

## Project setup
```
yarn install
```

### Compiles and hot-reloads for development
```
yarn serve
```

### Compiles and minifies for production
```
yarn build
```

### Lints and fixes files
```
yarn lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
