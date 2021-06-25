<div dir="rtl">
  
# قالب Firebase 
> Firebase startup template 

<img width="300" alt="Firebase template demo gif" src="https://user-images.githubusercontent.com/8784343/103164888-ecdd9f80-4821-11eb-885c-2b84173d11e9.gif" />



من خلال هذا القالب يمكنك إنشاء تطبيقات ترتبط بسحابة Firebase بكل سهولة. يمكنك اعادة استعمال بعض الـ Views مثل
- Sign in 
- Sign up 
- Add items
- List items

## ترتيب الملفات
<img width="556" alt="Firebase template files structure" src="https://user-images.githubusercontent.com/8784343/103164641-f74a6a00-481e-11eb-99e2-5ba56f45f273.png">

# 1. Authentication التوثيق
يمكنك التعديل على قالب صفحة تسجيل الدخول وإنشاء حساب جديد من خلال 
`Views > Authentication`

هناك 2 models مهمان في عملية تسجيل الدخول وعمل حساب جديد 

، هناك model باسم `User` و model اسم `SignInCredentials`. 
1. `User` هو المستعمل عند إنشاء حساب جديد. عادة تضع في الاسم، رقم الهاتف الإيميل، وغيرها من التفاصيل المهمة.  يعتبر وجود الإيميل مهم، ويجب أن لا يحتوي على كلمة المرور. يتم تمرير كلمة المرور في مكان لاحق. يستعمل عند عمل Sign up وعندما تستقبل تفاصيل المستخدم من قاعدة البيانات. 
يتم حفظ المستخدم عن عمل تسجيل دخول جديد تحت collection في Firebase باسم `users`
2. `SignInCredentials` ويحتوي فقط على الإيميل وكلمة المرور. وهو يستعمل عند عمل sign in فقط.


### كيف يعمل البرنامج؟ 
البرنامج يبدأ من خلال صفحة `MainApp`. حيث يقوم `MainApp` بإعادة بتفعيل `Firebase` ثم تشغيل واجهة `MainView` وإرسال `EnvironmentObject` الخاص ب `Firebase`. بحيث يمكن لكل الواجهات أسفل هذه الواجهات أن تصل إلى دوال ال `EnvironmentObject` المعرف باسم `FirebaseEnv` 

<div dir="ltr">
  
```swift
import SwiftUI
import Firebase
@main
struct MainApp: App {
    init() {
        // configuring Firebase
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(FirebaseEnv())
        }
    }
}
```

</div>

ثم `MainView` تقرر ما إذا كانت ستعرض صفحة طلب تسجيل الدخول أو الصفحة الرئيسية 
<div dir="ltr">
  
```swift
struct MainView: View {
    @EnvironmentObject var env: FirebaseEnv
    var body: some View {
        if env.signedIn{
            Home()
        }
        else{
            AuthenticationView()
        }
    }
}
```

</div>


يتم استعمال `FirebaseEnv` من أجل العمليات المتعلقة ب Firebase بشكل عام، مثل Sign in و Sign up و Sign out، وغيرها من الأمور المشتركة في جميع الواجهات. 


# 2. Database قواعد البيانات
يمكنك إضافة وحذف أي عنصر تريد إلى قاعدة البيانات في Firebase من خلال استعمال Firestore
الخطوات كالتالي: 
1. قم بعمل model جديد من خلال الذهاب إلى مجلد models وإنشاء ملف سويفت فارغ، وكتابة struct بهذا الشكل

<div dir="ltr">
  
```swift
struct Item: Codable, Hashable{
    var name: String
    var price: Double
}
```
</div>

يمكنك تسمية ال struct يأي اسم تشاء، وإضافة أي عدد تريد من أنواع البيانات الرئيسية مثل 
a. Int
b. String
c. Bool
d. Date
تأكد من إضافة `:Codable, Hashable` عند تعريف الكلاس، فهذا مايسمح لل struct أن يتم إرساله إلى قواعد البيانات بالانتنرت


2. قم بإنشاء envrionmentObject جديد من خلال عملل نسخة من ItemsEnv من داخل مجلد Environments 

يمكنك الاكتفاء بالكود التالي بدلاً من الكود المكتوب بداخل ItemsEnv


<div dir="ltr">
  
```swift
class ItemsEnv: ObservableObject{
    let collectionName = "MyItems" // ضع اسم للمكان الذي سيتم فيه الحفظ في قاعدة البيانات
    @Published var items: [Item] = [] // هنا تضع العناصر من النوع الذي قمت بإنشائه

    
    func loadItems(){
        Networking.getListOf(COLLECTION_NAME: collectionName) { (items: [Item]) in // تقوم هنا بتعديل النوع أيضاً 
            self.items = items
        }
    }
    
    func addItem(item: Item){ // لا تنسى تعديل النوع هنا أيضاً
        Networking.createItem(item, inCollection: collectionName) {
          // قم بوضع الكود الذي تريد أن يتم عندما يتم إضافة العنصر
        } fail: { (error) in
          // قم بوضع الكود الذي تريد أن يتم عندما تفشل عملية إضافة العنصر
        }
    }
}
```
</div>
  
  
3. قم بإنشاء واجهة لإضافة العنصر الجديد داخل صفحة Views. استعمل الـ EnvironmentObject الذي قمت بإنشائه في ال View الجديد بهذه الطريقة 


<div dir="ltr">
  
```swift
struct AddItem: View {
    @EnvironmentObject var itemsEnv: ItemsEnv // لا تنسى تغيير اسم ال Environment هنا
///    ... 
  var body: some View{
    /// ... 
  }
}
```
</div>

ولا تنسى عند استعمال View ل EnvironmentObject يجب تمرير نسخة من الـ EnvironmentObject من خلال `.environmentObject()` قبل اسم الواجهة
بنفس هذه الطريقة

<div dir="ltr">
  
  ```swift
MainView().environmentObject(FirebaseEnv())
  ```
</div>

والآن من خلال الواجهة الجديدة، لإضافة العنصر الجديد، قم بوضع الأمر بالمكان المناسب لذلك، واستعمل EnvironmentObject لإضافة عنصر من خلال الدالة التي كتبناها قبل قليل


<div dir="ltr">
  
  ```swift
itemsEnv.addItem(item: item)
  ```
</div>
  
  
4. يمكنك عرض قائمة من العناصر التي تمت إضافتها في قاعدة البيانات عادة من خلال أمر `onAppear`. قم بوضع الـ، modifier `onAppear` على آخر عنصر داخل ال `body` كالتالي: 

<div dir="ltr">
  
  ```swift
.onAppear(perform: itemsEnv.loadItems)
  ```
</div>

ولاتنسى أن تقوم بعرض العناصر من خلال `List` مثلاً كالتالي: 
<div dir="ltr">
  
  ```swift
List(itemsEnv.items, id: \.self){ item in 
   // ...
}
  ```
</div>

  
  </div>
