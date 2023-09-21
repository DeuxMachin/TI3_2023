

class Post{
  String title;
  String subtitle;
  String body;
  String author;
  String userImg;
  DateTime time;
  int likes= 0;
  bool userLiked = false;

  Post (this.title, this.subtitle, this.body, this.author, this.userImg, this.time);

  void likePost (){
    this.userLiked = !this.userLiked;
    if(this.userLiked){
      this.likes +=1;
    }else{
      this.likes -=1;
    }
  }
}
