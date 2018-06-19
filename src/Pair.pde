public class Pair<T, U> {         
    public T first;
    public U second;
    public Pair() {
      
    }
    
    public Pair(final T t, final U u) {         
        this.first = t;
        this.second = u;
     }
     
     public Pair(final Pair<T, U> p) {
      this.first = p.first;
      this.second = p.second;
     }
 }
