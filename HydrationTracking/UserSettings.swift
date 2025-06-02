import Foundation
import SwiftUI

// كلاس مشترك لحفظ بيانات المستخدم ومشاركتها بين الشاشات
class UserSettings: ObservableObject {

    // وزن المستخدم المدخل من شاشة البداية
    @Published var weight: Double = 0

    // كمية الماء اللي شربها المستخدم اليوم
    @Published var currentIntake: Double = 0
    
    @Published var intervalMinutes: Int = 15


    // وقت بداية التنبيهات
    @Published var startHour: Date = Date()

    // وقت نهاية التنبيهات
    @Published var endHour: Date = Date()

    // هدف الماء اليومي محسوب من الوزن (بدون تخزين مباشر)
    var dailyWaterTarget: Double {
        weight * 0.03
    }

    // دالة لإضافة كمية ماء مشروبة
    func addWater(amount: Double) {
        currentIntake += amount
    }

    // دالة لحساب نسبة التقدم نحو الهدف (للسيركل)
    func progressRatio() -> Double {
        guard dailyWaterTarget > 0 else { return 0 }
        return min(currentIntake / dailyWaterTarget, 1.0)
    }
}
