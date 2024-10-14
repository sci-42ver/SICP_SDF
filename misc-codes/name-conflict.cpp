// MyClass.h - Interface using PImpl idiom
#include <memory>
class MyClassImpl;
// Forward declaration of the implementation class
class MyClass {
public:
  MyClass();
  ~MyClass();
  // Destructor must be defined where MyClassImpl is fully defined, typically in
  // the .cpp file Other public interface methods
private:
  std ::unique_ptr<MyClassImpl> pImpl;
};
// MyClassImpl.h
#include "B.h" // Include library B's header where CHECK macro is defined
class MyClassImpl {
  // Implementation details that utilize B's CHECK macro
};
// MyClass.cc
#include "MyClass.h"
#include "MyClassImpl.h" // Include the PImpl implementation details
MyClass ::MyClass() : pImpl(new MyClassImpl()) {}