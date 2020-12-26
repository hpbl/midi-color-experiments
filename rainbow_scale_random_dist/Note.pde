public class Note {
  int pitch;
  color noteColor;
  int timesPlayed;
  
  public Note(int pitch, color noteColor) {
    this.pitch = pitch;
    this.noteColor = noteColor;
    this.timesPlayed = 0;
  }
  
  public float width() {
    return this.timesPlayed * 10;
  }
}
