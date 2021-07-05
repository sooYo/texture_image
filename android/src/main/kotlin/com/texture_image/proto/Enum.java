// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: enum.proto

package com.texture_image.proto;

public final class Enum {
  private Enum() {}
  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistryLite registry) {
  }

  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistry registry) {
    registerAllExtensions(
        (com.google.protobuf.ExtensionRegistryLite) registry);
  }
  /**
   * <pre>
   * Deliver image scale type between Flutter and native
   * </pre>
   *
   * Protobuf enum {@code BoxFit}
   */
  public enum BoxFit
      implements com.google.protobuf.ProtocolMessageEnum {
    /**
     * <code>fill = 0;</code>
     */
    fill(0),
    /**
     * <code>contain = 1;</code>
     */
    contain(1),
    /**
     * <code>cover = 2;</code>
     */
    cover(2),
    /**
     * <code>fitWidth = 3;</code>
     */
    fitWidth(3),
    /**
     * <code>fitHeight = 4;</code>
     */
    fitHeight(4),
    /**
     * <code>none = 5;</code>
     */
    none(5),
    UNRECOGNIZED(-1),
    ;

    /**
     * <code>fill = 0;</code>
     */
    public static final int fill_VALUE = 0;
    /**
     * <code>contain = 1;</code>
     */
    public static final int contain_VALUE = 1;
    /**
     * <code>cover = 2;</code>
     */
    public static final int cover_VALUE = 2;
    /**
     * <code>fitWidth = 3;</code>
     */
    public static final int fitWidth_VALUE = 3;
    /**
     * <code>fitHeight = 4;</code>
     */
    public static final int fitHeight_VALUE = 4;
    /**
     * <code>none = 5;</code>
     */
    public static final int none_VALUE = 5;


    public final int getNumber() {
      if (this == UNRECOGNIZED) {
        throw new java.lang.IllegalArgumentException(
            "Can't get the number of an unknown enum value.");
      }
      return value;
    }

    /**
     * @param value The numeric wire value of the corresponding enum entry.
     * @return The enum associated with the given numeric wire value.
     * @deprecated Use {@link #forNumber(int)} instead.
     */
    @java.lang.Deprecated
    public static BoxFit valueOf(int value) {
      return forNumber(value);
    }

    /**
     * @param value The numeric wire value of the corresponding enum entry.
     * @return The enum associated with the given numeric wire value.
     */
    public static BoxFit forNumber(int value) {
      switch (value) {
        case 0: return fill;
        case 1: return contain;
        case 2: return cover;
        case 3: return fitWidth;
        case 4: return fitHeight;
        case 5: return none;
        default: return null;
      }
    }

    public static com.google.protobuf.Internal.EnumLiteMap<BoxFit>
        internalGetValueMap() {
      return internalValueMap;
    }
    private static final com.google.protobuf.Internal.EnumLiteMap<
        BoxFit> internalValueMap =
          new com.google.protobuf.Internal.EnumLiteMap<BoxFit>() {
            public BoxFit findValueByNumber(int number) {
              return BoxFit.forNumber(number);
            }
          };

    public final com.google.protobuf.Descriptors.EnumValueDescriptor
        getValueDescriptor() {
      if (this == UNRECOGNIZED) {
        throw new java.lang.IllegalStateException(
            "Can't get the descriptor of an unrecognized enum value.");
      }
      return getDescriptor().getValues().get(ordinal());
    }
    public final com.google.protobuf.Descriptors.EnumDescriptor
        getDescriptorForType() {
      return getDescriptor();
    }
    public static final com.google.protobuf.Descriptors.EnumDescriptor
        getDescriptor() {
      return com.texture_image.proto.Enum.getDescriptor().getEnumTypes().get(0);
    }

    private static final BoxFit[] VALUES = values();

    public static BoxFit valueOf(
        com.google.protobuf.Descriptors.EnumValueDescriptor desc) {
      if (desc.getType() != getDescriptor()) {
        throw new java.lang.IllegalArgumentException(
          "EnumValueDescriptor is not for this type.");
      }
      if (desc.getIndex() == -1) {
        return UNRECOGNIZED;
      }
      return VALUES[desc.getIndex()];
    }

    private final int value;

    private BoxFit(int value) {
      this.value = value;
    }

    // @@protoc_insertion_point(enum_scope:BoxFit)
  }

  /**
   * <pre>
   * Describe image task state
   * </pre>
   *
   * Protobuf enum {@code ImageTaskState}
   */
  public enum ImageTaskState
      implements com.google.protobuf.ProtocolMessageEnum {
    /**
     * <pre>
     * Task has been created but not start yet
     * </pre>
     *
     * <code>initialized = 0;</code>
     */
    initialized(0),
    /**
     * <code>loading = 1;</code>
     */
    loading(1),
    /**
     * <pre>
     * Task completed successfully
     * </pre>
     *
     * <code>completed = 2;</code>
     */
    completed(2),
    /**
     * <code>canceled = 3;</code>
     */
    canceled(3),
    /**
     * <code>failed = 4;</code>
     */
    failed(4),
    UNRECOGNIZED(-1),
    ;

    /**
     * <pre>
     * Task has been created but not start yet
     * </pre>
     *
     * <code>initialized = 0;</code>
     */
    public static final int initialized_VALUE = 0;
    /**
     * <code>loading = 1;</code>
     */
    public static final int loading_VALUE = 1;
    /**
     * <pre>
     * Task completed successfully
     * </pre>
     *
     * <code>completed = 2;</code>
     */
    public static final int completed_VALUE = 2;
    /**
     * <code>canceled = 3;</code>
     */
    public static final int canceled_VALUE = 3;
    /**
     * <code>failed = 4;</code>
     */
    public static final int failed_VALUE = 4;


    public final int getNumber() {
      if (this == UNRECOGNIZED) {
        throw new java.lang.IllegalArgumentException(
            "Can't get the number of an unknown enum value.");
      }
      return value;
    }

    /**
     * @param value The numeric wire value of the corresponding enum entry.
     * @return The enum associated with the given numeric wire value.
     * @deprecated Use {@link #forNumber(int)} instead.
     */
    @java.lang.Deprecated
    public static ImageTaskState valueOf(int value) {
      return forNumber(value);
    }

    /**
     * @param value The numeric wire value of the corresponding enum entry.
     * @return The enum associated with the given numeric wire value.
     */
    public static ImageTaskState forNumber(int value) {
      switch (value) {
        case 0: return initialized;
        case 1: return loading;
        case 2: return completed;
        case 3: return canceled;
        case 4: return failed;
        default: return null;
      }
    }

    public static com.google.protobuf.Internal.EnumLiteMap<ImageTaskState>
        internalGetValueMap() {
      return internalValueMap;
    }
    private static final com.google.protobuf.Internal.EnumLiteMap<
        ImageTaskState> internalValueMap =
          new com.google.protobuf.Internal.EnumLiteMap<ImageTaskState>() {
            public ImageTaskState findValueByNumber(int number) {
              return ImageTaskState.forNumber(number);
            }
          };

    public final com.google.protobuf.Descriptors.EnumValueDescriptor
        getValueDescriptor() {
      if (this == UNRECOGNIZED) {
        throw new java.lang.IllegalStateException(
            "Can't get the descriptor of an unrecognized enum value.");
      }
      return getDescriptor().getValues().get(ordinal());
    }
    public final com.google.protobuf.Descriptors.EnumDescriptor
        getDescriptorForType() {
      return getDescriptor();
    }
    public static final com.google.protobuf.Descriptors.EnumDescriptor
        getDescriptor() {
      return com.texture_image.proto.Enum.getDescriptor().getEnumTypes().get(1);
    }

    private static final ImageTaskState[] VALUES = values();

    public static ImageTaskState valueOf(
        com.google.protobuf.Descriptors.EnumValueDescriptor desc) {
      if (desc.getType() != getDescriptor()) {
        throw new java.lang.IllegalArgumentException(
          "EnumValueDescriptor is not for this type.");
      }
      if (desc.getIndex() == -1) {
        return UNRECOGNIZED;
      }
      return VALUES[desc.getIndex()];
    }

    private final int value;

    private ImageTaskState(int value) {
      this.value = value;
    }

    // @@protoc_insertion_point(enum_scope:ImageTaskState)
  }


  public static com.google.protobuf.Descriptors.FileDescriptor
      getDescriptor() {
    return descriptor;
  }
  private static  com.google.protobuf.Descriptors.FileDescriptor
      descriptor;
  static {
    java.lang.String[] descriptorData = {
      "\n\nenum.proto*Q\n\006BoxFit\022\010\n\004fill\020\000\022\013\n\007cont" +
      "ain\020\001\022\t\n\005cover\020\002\022\014\n\010fitWidth\020\003\022\r\n\tfitHei" +
      "ght\020\004\022\010\n\004none\020\005*W\n\016ImageTaskState\022\017\n\013ini" +
      "tialized\020\000\022\013\n\007loading\020\001\022\r\n\tcompleted\020\002\022\014" +
      "\n\010canceled\020\003\022\n\n\006failed\020\004B\031\n\027com.texture_" +
      "image.protob\006proto3"
    };
    descriptor = com.google.protobuf.Descriptors.FileDescriptor
      .internalBuildGeneratedFileFrom(descriptorData,
        new com.google.protobuf.Descriptors.FileDescriptor[] {
        });
  }

  // @@protoc_insertion_point(outer_class_scope)
}
