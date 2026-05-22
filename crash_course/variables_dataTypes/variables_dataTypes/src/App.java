public class App {
    static int age;
    public static void main(String[] args) throws Exception {
        int age = 67;

        System.out.println("I am " + age + " years old.");
    }
}

class HelloWorld {
    public static void main(String[] args){
    // integer types
    byte aSingleByte = 100;
    short aSmallNumber = 20000;
    int anInteger = 67;
    // long aLargenumber = 92233720368547758;

    //decimal types
    double aDouble = 1.79;
    float aFloat = 1.73F;

    int number1 = 5;
    double number2 = number1;
    System.out.println(number2);

    double doubleNum1 = 5.8;
    int integerNum1 = (int)doubleNum1;
    System.out.println(integerNum1);
    }
}
