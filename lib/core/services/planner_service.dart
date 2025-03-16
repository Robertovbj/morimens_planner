import '../data/models/planner.dart';
import '../data/models/awaker.dart';

class PlannerService {
  /// Retrieves all planner entries from storage.
  ///
  /// [onlyActive] If set to true, returns only active plans. Defaults to false.
  /// Returns a Future that resolves to a list of [Planner] objects.
  Future<List<Planner>> getAllPlans({bool onlyActive = false}) async {
    final plans = await Planner.getAll();
    
    if (onlyActive) {
      return plans.where((plan) => plan.active).toList();
    }
    
    return plans;
  }

  /// Loads all plans and their related awakeners.
  ///
  /// Retrieves plans and constructs a map of awakeners for efficient lookup.
  /// Plans are sorted by their awakener's name.
  ///
  /// [onlyActive] When true, retrieves only active plans. Defaults to false.
  /// 
  /// Returns a tuple containing:
  /// - A list of [Planner] objects sorted by awakener name
  /// - A map of awakener IDs to [Awaker] objects for quick reference
  Future<(List<Planner>, Map<int, Awaker>)> loadPlansWithAwakers({bool onlyActive = false}) async {
    final plans = await getAllPlans(onlyActive: onlyActive);
    final allAwakers = await Awaker.getAll();
    final awakersMap = {for (var awaker in allAwakers) awaker.id!: awaker};

    // Sort plans by awakener name
    plans.sort((a, b) {
      final awakerA = awakersMap[a.awaker]?.name ?? '';
      final awakerB = awakersMap[b.awaker]?.name ?? '';
      return awakerA.compareTo(awakerB);
    });

    return (plans, awakersMap);
  }

  /// Activates a plan with the specified ID.
  /// 
  /// [planId] The ID of the plan to activate.
  /// 
  /// Returns a [Future] that completes with `true` when the plan is successfully activated.
  Future<bool> activatePlan(int planId) async {
    await Planner.activate(planId);
    return true;
  }

  /// Deactivates a plan with the specified ID.
  ///
  /// Makes the plan inactive in the system by calling the Planner's deactivate method.
  /// 
  /// [planId] The unique identifier of the plan to be deactivated.
  ///
  /// Returns a Future that completes with false when the operation is done.
  Future<bool> deactivatePlan(int planId) async {
    await Planner.deactivate(planId);
    return false;
  }

  /// Toggles the activation state of a plan.
  ///
  /// Takes a [planId] to identify the plan whose activation state needs to be toggled.
  ///
  /// Returns a [Future<bool>] that completes with the new activation state of the plan.
  Future<bool> togglePlanActive(int planId) async {
    return await Planner.toggleActive(planId);
  }
}
