class Observable {
  List<Observer> observers = [];
  notifyObservers(Object newValue) {
    for (Observer observer in observers) {
      observer.onChange(newValue);
    }
  }
}

class Observer {
  onChange(Object newValue) {}
}
