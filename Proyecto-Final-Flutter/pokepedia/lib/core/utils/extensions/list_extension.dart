// Permite agregar o eliminar un elemento de la lista de manera automática
extension ListWithToggleExtension on List {
  void toggleElement(Object? element) {
    if (contains(element)) {
      remove(element);
    } else {
      add(element);
    }
  }
}