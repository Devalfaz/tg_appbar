import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart'
    hide
        RenderSliverPersistentHeader,
        RenderSliverPinnedPersistentHeader,
        FloatingHeaderSnapConfiguration,
        OverScrollHeaderStretchConfiguration,
        PersistentHeaderShowOnScreenConfiguration
    //     RenderSliverScrollingPersistentHeader,
    //     RenderSliverFloatingPersistentHeader
    ;
import 'package:flutter/scheduler.dart' show TickerProvider;
import 'header.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/scroll_position.dart';
import 'package:flutter/src/widgets/scrollable.dart';
// import 'package:tg_appbar/header.dart';

abstract class TgPersistentHeaderDelegate {
  const TgPersistentHeaderDelegate();

  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent);

  double get minExtent;

  double get maxExtent;

  TickerProvider? get vsync => null;

  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;

  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      null;

  bool shouldRebuild(covariant TgPersistentHeaderDelegate oldDelegate);
}

class TgPersistentHeader extends StatelessWidget {
  const TgPersistentHeader({
    super.key,
    required this.delegate,
    this.pinned = false,
    this.floating = false,
  })  : assert(delegate != null),
        assert(pinned != null),
        assert(floating != null);

  final TgPersistentHeaderDelegate delegate;

  final bool pinned;

  final bool floating;

  @override
  Widget build(BuildContext context) {
    // if (floating && pinned) {
    //   return _SliverFloatingPinnedPersistentHeader(delegate: delegate);
    // }
    // if (pinned) {
    return _SliverPinnedPersistentHeader(delegate: delegate);
    // }
    // if (floating) {
    //   return _SliverFloatingPersistentHeader(delegate: delegate);
    // }
    // return _SliverScrollingPersistentHeader(delegate: delegate);
  }
}

// class _FloatingHeader extends StatefulWidget {
//   const _FloatingHeader({required this.child});

//   final Widget child;

//   @override
//   _FloatingHeaderState createState() => _FloatingHeaderState();
// }

// class _FloatingHeaderState extends State<_FloatingHeader> {
//   ScrollPosition? _position;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (_position != null) {
//       _position!.isScrollingNotifier.removeListener(_isScrollingListener);
//     }
//     _position = Scrollable.of(context)?.position;
//     if (_position != null) {
//       _position!.isScrollingNotifier.addListener(_isScrollingListener);
//     }
//   }

//   @override
//   void dispose() {
//     if (_position != null) {
//       _position!.isScrollingNotifier.removeListener(_isScrollingListener);
//     }
//     super.dispose();
//   }

//   RenderSliverFloatingPersistentHeader? _headerRenderer() {
//     return context
//         .findAncestorRenderObjectOfType<RenderSliverFloatingPersistentHeader>();
//   }

//   void _isScrollingListener() {
//     assert(_position != null);

//     final RenderSliverFloatingPersistentHeader? header = _headerRenderer();
//     if (_position!.isScrollingNotifier.value) {
//       header?.updateScrollStartDirection(_position!.userScrollDirection);

//       header?.maybeStopSnapAnimation(_position!.userScrollDirection);
//     } else {
//       header?.maybeStartSnapAnimation(_position!.userScrollDirection);
//     }
//   }

//   @override
//   Widget build(BuildContext context) => widget.child;
// }

class _SliverPersistentHeaderElement extends RenderObjectElement {
  _SliverPersistentHeaderElement(
    _SliverPersistentHeaderRenderObjectWidget super.widget, {
    this.floating = false,
  }) : assert(floating != null);

  final bool floating;

  @override
  _RenderSliverPersistentHeaderForWidgetsMixin get renderObject =>
      super.renderObject as _RenderSliverPersistentHeaderForWidgetsMixin;

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    renderObject._element = this;
  }

  @override
  void unmount() {
    renderObject._element = null;
    super.unmount();
  }

  @override
  void update(_SliverPersistentHeaderRenderObjectWidget newWidget) {
    final _SliverPersistentHeaderRenderObjectWidget oldWidget =
        widget as _SliverPersistentHeaderRenderObjectWidget;
    super.update(newWidget);
    final TgPersistentHeaderDelegate newDelegate = newWidget.delegate;
    final TgPersistentHeaderDelegate oldDelegate = oldWidget.delegate;
    if (newDelegate != oldDelegate &&
        (newDelegate.runtimeType != oldDelegate.runtimeType ||
            newDelegate.shouldRebuild(oldDelegate))) {
      renderObject.triggerRebuild();
    }
  }

  @override
  void performRebuild() {
    super.performRebuild();
    renderObject.triggerRebuild();
  }

  Element? child;

  void _build(double shrinkOffset, bool overlapsContent) {
    owner!.buildScope(this, () {
      final _SliverPersistentHeaderRenderObjectWidget
          sliverPersistentHeaderRenderObjectWidget =
          widget as _SliverPersistentHeaderRenderObjectWidget;
      child = updateChild(
        child,
        sliverPersistentHeaderRenderObjectWidget.delegate
            .build(this, shrinkOffset, overlapsContent),
        null,
      );
    });
  }

  @override
  void forgetChild(Element child) {
    assert(child == this.child);
    this.child = null;
    super.forgetChild(child);
  }

  @override
  void insertRenderObjectChild(covariant RenderBox child, Object? slot) {
    assert(renderObject.debugValidateChild(child));
    renderObject.child = child;
  }

  @override
  void moveRenderObjectChild(
      covariant RenderObject child, Object? oldSlot, Object? newSlot) {
    assert(false);
  }

  @override
  void removeRenderObjectChild(covariant RenderObject child, Object? slot) {
    renderObject.child = null;
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    if (child != null) {
      visitor(child!);
    }
  }
}

abstract class _SliverPersistentHeaderRenderObjectWidget
    extends RenderObjectWidget {
  const _SliverPersistentHeaderRenderObjectWidget({
    required this.delegate,
    this.floating = false,
  })  : assert(delegate != null),
        assert(floating != null);

  final TgPersistentHeaderDelegate delegate;
  final bool floating;

  @override
  _SliverPersistentHeaderElement createElement() =>
      _SliverPersistentHeaderElement(this, floating: floating);

  @override
  _RenderSliverPersistentHeaderForWidgetsMixin createRenderObject(
      BuildContext context);
}

mixin _RenderSliverPersistentHeaderForWidgetsMixin
    on RenderSliverPersistentHeader {
  _SliverPersistentHeaderElement? _element;

  @override
  double get minExtent =>
      (_element!.widget as _SliverPersistentHeaderRenderObjectWidget)
          .delegate
          .minExtent;

  @override
  double get maxExtent =>
      (_element!.widget as _SliverPersistentHeaderRenderObjectWidget)
          .delegate
          .maxExtent;

  @override
  void updateChild(double shrinkOffset, bool overlapsContent) {
    assert(_element != null);
    _element!._build(shrinkOffset, overlapsContent);
  }

  @protected
  void triggerRebuild() {
    markNeedsLayout();
  }
}

class _SliverPinnedPersistentHeader
    extends _SliverPersistentHeaderRenderObjectWidget {
  const _SliverPinnedPersistentHeader({
    required super.delegate,
  });

  @override
  _RenderSliverPersistentHeaderForWidgetsMixin createRenderObject(
      BuildContext context) {
    return _RenderSliverPinnedPersistentHeaderForWidgets(
      stretchConfiguration: delegate.stretchConfiguration,
      showOnScreenConfiguration: delegate.showOnScreenConfiguration,
    );
  }
}

class _RenderSliverPinnedPersistentHeaderForWidgets
    extends RenderSliverPinnedPersistentHeader
    with _RenderSliverPersistentHeaderForWidgetsMixin {
  _RenderSliverPinnedPersistentHeaderForWidgets({
    super.stretchConfiguration,
    super.showOnScreenConfiguration,
  });
}

// class _SliverScrollingPersistentHeader
//     extends _SliverPersistentHeaderRenderObjectWidget {
//   const _SliverScrollingPersistentHeader({
//     required super.delegate,
//   });

//   @override
//   _RenderSliverPersistentHeaderForWidgetsMixin createRenderObject(
//       BuildContext context) {
//     return _RenderSliverScrollingPersistentHeaderForWidgets(
//       stretchConfiguration: delegate.stretchConfiguration,
//     );
//   }
// }

// class _RenderSliverScrollingPersistentHeaderForWidgets
//     extends RenderSliverScrollingPersistentHeader
//     with _RenderSliverPersistentHeaderForWidgetsMixin {
//   _RenderSliverScrollingPersistentHeaderForWidgets({
//     super.stretchConfiguration,
//   });
// }

// class _SliverFloatingPersistentHeader
//     extends _SliverPersistentHeaderRenderObjectWidget {
//   const _SliverFloatingPersistentHeader({
//     required super.delegate,
//   }) : super(
//           floating: true,
//         );

//   @override
//   _RenderSliverPersistentHeaderForWidgetsMixin createRenderObject(
//       BuildContext context) {
//     return _RenderSliverFloatingPersistentHeaderForWidgets(
//       vsync: delegate.vsync,
//       snapConfiguration: delegate.snapConfiguration,
//       stretchConfiguration: delegate.stretchConfiguration,
//       showOnScreenConfiguration: delegate.showOnScreenConfiguration,
//     );
//   }

//   @override
//   void updateRenderObject(BuildContext context,
//       _RenderSliverFloatingPersistentHeaderForWidgets renderObject) {
//     renderObject.vsync = delegate.vsync;
//     renderObject.snapConfiguration = delegate.snapConfiguration;
//     renderObject.stretchConfiguration = delegate.stretchConfiguration;
//     renderObject.showOnScreenConfiguration = delegate.showOnScreenConfiguration;
//   }
// }

// class _RenderSliverFloatingPinnedPersistentHeaderForWidgets
//     extends RenderSliverFloatingPinnedPersistentHeader
//     with _RenderSliverPersistentHeaderForWidgetsMixin {
//   _RenderSliverFloatingPinnedPersistentHeaderForWidgets({
//     required super.vsync,
//     super.snapConfiguration,
//     super.stretchConfiguration,
//     super.showOnScreenConfiguration,
//   });
// }

// class _SliverFloatingPinnedPersistentHeader
//     extends _SliverPersistentHeaderRenderObjectWidget {
//   const _SliverFloatingPinnedPersistentHeader({
//     required super.delegate,
//   }) : super(
//           floating: true,
//         );

//   @override
//   _RenderSliverPersistentHeaderForWidgetsMixin createRenderObject(
//       BuildContext context) {
//     return _RenderSliverFloatingPinnedPersistentHeaderForWidgets(
//       vsync: delegate.vsync,
//       snapConfiguration: delegate.snapConfiguration,
//       stretchConfiguration: delegate.stretchConfiguration,
//       showOnScreenConfiguration: delegate.showOnScreenConfiguration,
//     );
//   }

//   @override
//   void updateRenderObject(BuildContext context,
//       _RenderSliverFloatingPinnedPersistentHeaderForWidgets renderObject) {
//     renderObject.vsync = delegate.vsync;
//     renderObject.snapConfiguration = delegate.snapConfiguration;
//     renderObject.stretchConfiguration = delegate.stretchConfiguration;
//     renderObject.showOnScreenConfiguration = delegate.showOnScreenConfiguration;
//   }
// }

// class _RenderSliverFloatingPersistentHeaderForWidgets
//     extends RenderSliverFloatingPersistentHeader
//     with _RenderSliverPersistentHeaderForWidgetsMixin {
//   _RenderSliverFloatingPersistentHeaderForWidgets({
//     required super.vsync,
//     super.snapConfiguration,
//     super.stretchConfiguration,
//     super.showOnScreenConfiguration,
//   });
// }
