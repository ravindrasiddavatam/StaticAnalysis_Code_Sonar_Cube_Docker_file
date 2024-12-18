import java.util.*;
public class main { // Non-standard class name (Should be "Main")

    public static void main(String[] args) {
        // Issue 1: Unused variable (Maintainability)
        int unusedVariable = 10;

        // Issue 2: Hardcoded sensitive information (Security)
        String password = "12345"; // Sensitive data hardcoded

        // Issue 3: NullPointerException risk (Reliability)
        String riskyString = null;
        System.out.println(riskyString.length()); // This will throw NullPointerException

        // Issue 4: Resource leak (Reliability)
        try {
            java.io.FileInputStream fis = new java.io.FileInputStream("example.txt");
            System.out.println(fis.read());
        } catch (java.io.IOException e) {
            e.printStackTrace();
        }

        // Issue 5: Redundant conditional (Maintainability)
        if (true) {
            System.out.println("This will always execute.");
        } else {
            System.out.println("This will never execute.");
        }

        // Issue 6: Inefficient string concatenation (Performance)
        String result = "";
        for (int i = 0; i < 100; i++) {
            result += i; // Use StringBuilder for better performance
        }
        System.out.println(result);
    }
}
